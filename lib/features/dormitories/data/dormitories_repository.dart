import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../../config/utils.dart';
import '../../../exceptions/app_exception.dart';
import '../../../main.dart';
import '../../authentication/data/auth_repository.dart';
import '../../authentication/domain/user.dart';
import '../domain/dormitory.dart';
import '../domain/room_booking.dart';

class DormitoriesRepository {
  final Dio _dio = getIt<Dio>();

  Future<List<Dormitory>> retrieveDormitories() async {
    late final Response<List> response;
    try {
      response = await _dio.get<List>('/dormitories/');
    } on DioError {
      throw const AppException.someErrorOccurred();
    }
    if (response.data == null) {
      throw const AppException.someErrorOccurred();
    }

    return (response.data as List)
        .map((dynamic e) => Dormitory.fromJson(e as ResponseJson))
        .toList();
  }

  Future<RoomBookingPreview> previewRoomBooking(
      User? user, String dormitoryId, String roomId) async {
    if (user is! User) {
      // по идее мы в роутинге должны перебросить на логин
      throw const AppException.userNotFound();
    }

    final opt = Options(
      headers: <String, dynamic>{
        'Authorization': 'Bearer ${user.token}',
      },
    );
    late final Response<ResponseJson> response;
    try {
      response = await _dio.get<ResponseJson>(
          '/dormitories/$dormitoryId/booking/$roomId',
          options: opt);
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw const AppException.userNotFound();
      }

      throw const AppException.someErrorOccurred();
    }

    if (response.data == null) {
      throw const AppException.someErrorOccurred();
    }

    return RoomBookingPreview.fromJson(response.data!);
  }

  Future<bool> bookRoom({
    User? user,
    required String dormitoryId,
    required String roomId,
    required DateTime fromDate,
    required DateTime toDate,
    required int guestsCount,
  }) async {
    if (user is! User) {
      // по идее мы в роутинге должны перебросить на логин
      throw const AppException.userNotFound();
    }

    final opt = Options(
      headers: <String, dynamic>{
        'Authorization': 'Bearer ${user.token}',
      },
    );
    late final Response<ResponseJson> response;
    try {
      response = await _dio.post<ResponseJson>(
        '/dormitories/$dormitoryId/booking/$roomId',
        data: {
          'guests_count': guestsCount,
          'date_from': fromDate.millisecondsSinceEpoch,
          'date_to': toDate.millisecondsSinceEpoch,
        },
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

    return true;
  }
}

final dormitoriesRepositoryProvider =
    Provider((ref) => DormitoriesRepository());

final dormitoriesProvider = FutureProvider<List<Dormitory>>((ref) {
  final dormitoriesRepository = ref.watch(dormitoriesRepositoryProvider);
  return dormitoriesRepository.retrieveDormitories();
});

final bookingPreviewProvider = FutureProvider.autoDispose
    .family<RoomBookingPreview, Tuple2<String, String>>((ref, dormitoryRoom) {
  final authRepository = ref.watch(authRepositoryProvider);
  final dormitoriesRepository = ref.watch(dormitoriesRepositoryProvider);

  return dormitoriesRepository.previewRoomBooking(
    authRepository.currentUser,
    dormitoryRoom.item1,
    dormitoryRoom.item2,
  );
});
