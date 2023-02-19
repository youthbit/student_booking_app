import 'dart:math';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';

import '../../authentication/data/auth_repository.dart';
import '../../routing/router_spec.dart';
import '../data/dormitories_repository.dart';
import '../data/room_type.dart';

isNumeric(string) => num.tryParse(string) != null;

extension FormatShort on MaterialLocalizations {
  Tuple2<String, String> splitShortMonthDay(DateTime date) {
    final parts = formatShortMonthDay(date).split(' ');

    return isNumeric(parts[0])
        ? Tuple2(parts[0], parts[1])
        : Tuple2(parts[1], parts[0]);
  }
}

class DormitoryBookingPage extends ConsumerStatefulWidget {
  final String roomId;
  final String dormitoryId;

  const DormitoryBookingPage({
    required this.dormitoryId,
    required this.roomId,
    super.key,
  });

  @override
  ConsumerState<DormitoryBookingPage> createState() =>
      DormitoryBookingPageState();
}

class DormitoryBookingPageState extends ConsumerState<DormitoryBookingPage> {
  List<DateTime>? selectedDates;
  int guestsCount = 0;

  @override
  Widget build(BuildContext context) {
    final bookingPreview = ref.watch(
      bookingPreviewProvider(Tuple2(widget.dormitoryId, widget.roomId)),
    );

    return Scaffold(
      body: bookingPreview.when(
        error: (error, stack) => Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        loading: () => Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        data: (preview) => Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    iconTheme: IconThemeData(
                      color: Theme.of(context).iconTheme.color,
                    ),
                    pinned: true,
                    title: Text(
                      preview.dormitory,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Новое бронирование',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                            'Пожалуйста, перепроверьте автоматически заполненные поля',
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            preview.dormitory,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.place_outlined,
                                size: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .fontSize,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  preview.address,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.bed_rounded,
                                size: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .fontSize,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  preview.roomType,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            preview.name,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.alternate_email_rounded,
                                size: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .fontSize,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  preview.email,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.sim_card_outlined,
                                size: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .fontSize,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  preview.phone,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 25.0,
                            left: 20.0,
                            right: 20.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            'Даты',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color(0xFF393939),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                              height: 300,
                              child: CalendarDatePicker2(
                                initialValue: selectedDates ?? [],
                                config: CalendarDatePicker2Config(
                                  calendarType: CalendarDatePicker2Type.range,
                                  disableYearPicker: true,
                                  controlsTextStyle:
                                      Theme.of(context).textTheme.bodyLarge,
                                  weekdayLabelTextStyle:
                                      Theme.of(context).textTheme.headlineSmall,
                                  dayTextStyle:
                                      Theme.of(context).textTheme.bodyLarge,
                                  selectedDayHighlightColor: Colors.white,
                                  selectedDayTextStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black),
                                ),
                                onValueChanged: (values) {
                                  if (values.length == 2) {
                                    setState(() {
                                      selectedDates = [values[0]!, values[1]!];
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 25.0,
                            left: 20.0,
                            right: 20.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            'Гости',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color(0xFF393939),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text('Students',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      Text(
                                        '18-35 лет',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      if (guestsCount > 1) {
                                        setState(() {
                                          guestsCount = guestsCount - 1;
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                    ),
                                  ),
                                  Text(
                                    '$guestsCount',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (guestsCount <
                                          min(
                                            preview.available,
                                            RoomType.fromString(
                                              preview.roomType,
                                            ).maxQuantity,
                                          )) {
                                        setState(() {
                                          guestsCount = guestsCount + 1;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ColoredBox(
              color: Theme.of(context).iconTheme.color!,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: max(MediaQuery.of(context).viewPadding.bottom, 20.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          preview.roomType,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).primaryIconTheme.color),
                        ),
                        selectedDates == null
                            ? Text(
                                'выберите даты',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .primaryIconTheme
                                            .color),
                              )
                            : RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: MaterialLocalizations.of(context)
                                          .splitShortMonthDay(selectedDates![0])
                                          .item1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color),
                                    ),
                                    TextSpan(
                                      text:
                                          ' ${MaterialLocalizations.of(context).splitShortMonthDay(selectedDates![0]).item2} – ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color),
                                    ),
                                    TextSpan(
                                      text: MaterialLocalizations.of(context)
                                          .splitShortMonthDay(selectedDates![1])
                                          .item1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color),
                                    ),
                                    TextSpan(
                                      text:
                                          ' ${MaterialLocalizations.of(context).splitShortMonthDay(selectedDates![1]).item2}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: selectedDates == null
                              ? null
                              : () {
                                  final dormitoriesRepository =
                                      ref.read(dormitoriesRepositoryProvider);
                                  final authRepository =
                                      ref.read(authRepositoryProvider);

                                  dormitoriesRepository
                                      .bookRoom(
                                    user: authRepository.currentUser,
                                    dormitoryId: widget.dormitoryId,
                                    roomId: widget.roomId,
                                    fromDate: selectedDates![0],
                                    toDate: selectedDates![1],
                                    guestsCount: guestsCount,
                                  )
                                      .then(
                                    (value) {
                                      context.push(RouteSpec.success.path);
                                    },
                                    onError: (error, stack) {
                                      context.push(RouteSpec.error.path);
                                    },
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                color: selectedDates == null
                                    ? const Color(0xFF393939)
                                    : Theme.of(context).primaryIconTheme.color!,
                              ),
                            ),
                            backgroundColor:
                                Theme.of(context).primaryIconTheme.color,
                            disabledBackgroundColor: const Color(0xFF393939),
                          ),
                          child: Text(
                            'ПОДТВЕРДИТЬ БРОНИРОВАНИЕ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: Theme.of(context).iconTheme.color),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
