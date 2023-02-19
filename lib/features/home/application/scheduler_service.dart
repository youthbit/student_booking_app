import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/local_calendar_repository.dart';
import '../data/remote_calendar_repository.dart';
import '../domain/event.dart';

part 'scheduler_service.g.dart';

class SchedulerService {
  final Ref ref;

  SchedulerService(this.ref);

  Future<List<Event>> fetchSchedule() async {
    final result = await InternetConnectionChecker().hasConnection;
    if (result) {
      try {
        final remoteRepository =
            await ref.read(remoteCalendarRepositoryProvider).fetchEventsList();
        return remoteRepository;
      } on Exception {
        return ref.read(localCalendarRepositoryProvider).fetchCalendar();
      }
    } else {
      return ref.read(localCalendarRepositoryProvider).fetchCalendar();
    }
  }
}

@Riverpod(keepAlive: true)
SchedulerService schedulerService(SchedulerServiceRef ref) {
  return SchedulerService(ref);
}

final scheduleProvider = FutureProvider<List<Event>>((ref) async {
  return await ref.read(schedulerServiceProvider).fetchSchedule();
});
