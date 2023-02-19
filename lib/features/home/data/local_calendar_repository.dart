import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../main.dart';
import '../../authentication/data/auth_utils.dart';
import '../domain/event.dart';

part 'local_calendar_repository.g.dart';

typedef ResponseJson = Map<String, dynamic>;

class LocalCalendarRepository {
  final bool addDelay;
  final Isar _isar = getIt<Isar>();
  final Logger _logger = getIt<Logger>();

  LocalCalendarRepository({this.addDelay = true});

  Future<List<Event>> fetchCalendar() async {
    await delay(addDelay: addDelay);
    final events = await _isar.events.where().findAll();
    _logger.i('LocalCalendarRepository: fetched events list: $events');
    return events;
  }

  Future<List<Id>> retrieveCalendar(List<Event> events) async {
    await delay(addDelay: addDelay);
    final result = await _isar.writeTxn(() async {
      final result = await _isar.events.putAll(events);
      _logger.i('LocalCalendarRepository: retrieved events list: $result');
    });
    return result;
  }
}

@Riverpod(keepAlive: true)
LocalCalendarRepository localCalendarRepository(
  LocalCalendarRepositoryRef ref,
) {
  return LocalCalendarRepository(addDelay: false);
}
