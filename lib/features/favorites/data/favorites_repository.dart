import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

import '../../../config/utils.dart';
import '../../../exceptions/app_exception.dart';
import '../../../main.dart';
import '../../authentication/data/auth_repository.dart';
import '../../authentication/domain/user.dart';

class FavoritesRepository {
  final Dio _dio = getIt<Dio>();

  Future<bool> addDormitoryToFavorites(User? user, String dormitoryId) async {
    if (user is! User) {
      // TODO: выплевывать попап что фича для логинов онли
      return false;
    }

    final opt = Options(
      headers: <String, dynamic>{
        'Authorization': 'Bearer ${user.token}',
      },
    );
    try {
      await _dio.put<ResponseJson>(
        '/favorites/dormitories/$dormitoryId',
        options: opt,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw const AppException.userNotFound();
      }

      throw const AppException.someErrorOccurred();
    }

    return true;
  }

  Future<bool> removeDormitoryFromFavorites(
      User? user, String dormitoryId) async {
    if (user is! User) {
      // TODO: выплевывать попап что фича для логинов онли
      return false;
    }

    final opt = Options(
      headers: <String, dynamic>{
        'Authorization': 'Bearer ${user.token}',
      },
    );
    try {
      await _dio.delete<ResponseJson>(
        '/favorites/dormitories/$dormitoryId',
        options: opt,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw const AppException.userNotFound();
      }

      throw const AppException.someErrorOccurred();
    }

    return true;
  }

  Future<List<String>> retrieveFavoritesDormitories(User? user) async {
    if (user is! User) {
      return const [];
    }

    final opt = Options(
      headers: <String, dynamic>{
        'Authorization': 'Bearer ${user.token}',
      },
    );
    late final Response<List<dynamic>> response;
    try {
      response = await _dio.get<List<dynamic>>(
        '/favorites/dormitories/',
        options: opt,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw const AppException.userNotFound();
      }

      throw const AppException.someErrorOccurred();
    }

    if (response.data == null) {
      throw const AppException.someErrorOccurred();
    }

    return response.data!.map((e) => e as String).toList();
  }
}

final favoritesRepositoryProvider = Provider((ref) => FavoritesRepository());
