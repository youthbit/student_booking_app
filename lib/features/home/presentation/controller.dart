import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../application/scheduler_service.dart';
import '../domain/event.dart';

class StackedCalendarController extends StateNotifier<Tuple2<Event?, int>> {
  StackedCalendarController(super.state);

  void toggle(Event data, int index) {
    print('TOGGLE : $index');
    state = Tuple2(data, index);
  }
}

final stackedCalendarControllerProvider =
    StateNotifierProvider<StackedCalendarController, Tuple2<Event?, int>>(
  (ref) {
    final scheduleService = ref.watch(scheduleProvider);
    return scheduleService.maybeWhen(
      data: (events) => StackedCalendarController(
        Tuple2(events.first, 0),
      ),
      orElse: () => StackedCalendarController(
        const Tuple2(null, 0),
      ),
    );
  },
);
