import 'dart:convert';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/utils.dart';
import '../../exceptions/app_exception.dart';
import '../../main.dart';
import '../authentication/data/auth_repository.dart';
import '../authentication/domain/user.dart';
import 'domain/avatar.dart';
import 'domain/part.dart';
import 'domain/part_type.dart';

typedef AssetsManifest = Map<String, dynamic>;

class AvatarsRepository {
  final Dio _dio = getIt<Dio>();
  final Map<PartType, List<String>> _partsLibrary = {};
  Avatar? _avatar;

  // ignore: implicit-dynamic
  AssetsManifest? _assetsManifest;

  Future<List<String>> listPartsFor(PartType partType) async {
    _partsLibrary[partType] ??= await _listPartsFor(partType);

    return _partsLibrary[partType]!;
  }

  Future<Avatar?> retrieveUserAvatar(User? user) async {
    if (_avatar != null) return _avatar;
    if (user is! User) return null;

    late final Response<ResponseJson> response;
    try {
      response = await _dio.get<ResponseJson>('/avatars/${user.id}');
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw const AppException.userNotFound();
      }

      if (e.response?.statusCode == 404) {
        return null;
      }

      throw const AppException.someErrorOccurred();
    }
    if (response.data == null) {
      return null;
    }

    _avatar = await Avatar.fromJson(response.data!);
    return _avatar;
  }

  Future<void> saveUserAvatar(User user, Avatar avatar) async {
    final opt = Options(
      headers: <String, dynamic>{
        'Authorization': 'Bearer ${user.token}',
      },
    );
    try {
      await _dio.post<ResponseJson>(
        '/avatars/${user.id}',
        data: avatar.toJson(),
        options: opt,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw const AppException.userNotFound();
      }

      throw const AppException.someErrorOccurred();
    }

    _avatar = avatar;
  }

  Future<AssetsManifest> _getAssetsManifest() async {
    _assetsManifest ??= await _loadManifest();

    return _assetsManifest!;
  }

  Future<List<String>> _listPartsFor(PartType partType) async {
    final manifest = await _getAssetsManifest();
    final paths = manifest.keys
        .where((key) => key.startsWith('assets/avatars/${partType.key}'));

    return paths.toList()..sort((a, b) => a.contains('None') ? 0 : 1);
  }

  Future<AssetsManifest> _loadManifest() async {
    final receivePort = ReceivePort();
    final manifestJson = await rootBundle.loadString('AssetManifest.json');

    await Isolate.spawn(
      (args) async {
        (args[0] as SendPort)
            .send(json.decode(args[1] as String) as AssetsManifest);
      },
      [
        receivePort.sendPort,
        manifestJson,
      ],
    );

    return await receivePort.first as AssetsManifest;
  }
}

final avatarsRepositoryProvider =
    Provider<AvatarsRepository>((ref) => AvatarsRepository());

final partsProvider = FutureProvider.family<List<Part>, PartType>((
  ref,
  partType,
) async {
  final avatarsRepository = ref.watch(avatarsRepositoryProvider);

  PictureProvider.cache.clear();

  final paths = await avatarsRepository.listPartsFor(partType);
  return Future.wait(paths.map(Part.load));
});

final avatarProvider = FutureProvider<Avatar>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  final avatarsRepository = ref.watch(avatarsRepositoryProvider);

  return await avatarsRepository
          .retrieveUserAvatar(authRepository.currentUser) ??
      await Avatar.random(avatarsRepository);
});

final renderedAvatarProvider = FutureProvider.autoDispose
    .family<RenderedAvatar?, Avatar>((ref, avatar) async {
  return avatar.render();
});
