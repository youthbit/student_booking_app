import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../main.dart';
import '../domain/event.dart';
import 'local_calendar_repository.dart';

part 'remote_calendar_repository.g.dart';

typedef ResponseJson = Map<String, dynamic>;

class RemoteCalendarRepository {
  final bool addDelay;
  final Ref ref;
  final Dio _dio = getIt<Dio>();
  final Logger _logger = getIt<Logger>();

  RemoteCalendarRepository(this.ref, {this.addDelay = true});

  Future<List<Event>> fetchEventsList() async {
    try {
      final response = await _dio.get(
        '/events/',
      );
      final events = (response.data as List)
          .map((dynamic e) => Event.fromJson(e as ResponseJson))
          .toList();
      ref.read(localCalendarRepositoryProvider).retrieveCalendar(events);
      _logger.i('RemoteCalendarRepository: fetched events list: $events');
      return events;
    } on Error catch (e) {
      _logger.e('RemoteCalendarRepository: Error: $e');
      throw UnimplementedError(e.stackTrace.toString());
    }
  }
}

@riverpod
RemoteCalendarRepository remoteCalendarRepository(
  RemoteCalendarRepositoryRef ref,
) {
  return RemoteCalendarRepository(ref, addDelay: false);
}

@riverpod
Future<List<Event>> remoteCalendarFuture(RemoteCalendarFutureRef ref) {
  final remoteCalendarRepository = ref.watch(remoteCalendarRepositoryProvider);
  return remoteCalendarRepository.fetchEventsList();
}
