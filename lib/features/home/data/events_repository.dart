import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/utils.dart';
import '../../../exceptions/app_exception.dart';
import '../../../main.dart';
import '../../authentication/domain/user.dart';
import '../domain/event_details.dart';

class EventsRepository {
  final Dio _dio = getIt<Dio>();

  Future<EventDetails> retrieveEventDetails(
    String eventId,
  ) async {
    late final Response<ResponseJson> response;
    try {
      response = await _dio.get<ResponseJson>(
        '/events/$eventId',
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw const AppException.someErrorOccurred();
      }

      throw const AppException.someErrorOccurred();
    }

    if (response.data == null) {
      throw const AppException.someErrorOccurred();
    }

    return EventDetails.fromJson(response.data!);
  }

  Future<bool> bookEvent({
    required User user,
    required String eventId,
    required int guestsCount,
  }) async {
    final opt = Options(
      headers: <String, dynamic>{
        'Authorization': 'Bearer ${user.token}',
      },
    );
    late final Response<ResponseJson> response;
    try {
      response = await _dio.post<ResponseJson>(
        '/events/$eventId/booking',
        data: {
          'guests_count': guestsCount,
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

final eventsRepositoryProvider = Provider((ref) => EventsRepository());
