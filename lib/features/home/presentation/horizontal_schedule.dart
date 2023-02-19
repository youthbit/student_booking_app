import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youthbit/features/home/presentation/vertical_schedule.dart';
import 'package:youthbit/features/home/presentation/widgets/date_picker_item.dart';
import 'package:youthbit/features/home/presentation/widgets/event_card.dart';

import '../../../config/general/on_tap_opacity_container.dart';
import '../../routing/router_spec.dart';
import '../domain/event.dart';
import 'controller.dart';

class HorizontalSchedule extends ConsumerStatefulWidget {
  final SwiperController swiperControllerDate;
  final SwiperController swiperControllerCard;
  final List<Event> events;

  const HorizontalSchedule({
    required this.swiperControllerDate,
    required this.swiperControllerCard,
    required this.events,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HorizontalSchedule> createState() => _HorizontalScheduleState();
}

class _HorizontalScheduleState extends ConsumerState<HorizontalSchedule>
    with SingleTickerProviderStateMixin {
  late int dateCurrentIndex;
  late int realState;
  late int cardCurrentIndex;
  late bool selected;

  @override
  void initState() {
    super.initState();
    dateCurrentIndex = 2;
    selected = false;
    cardCurrentIndex = 2;
    realState = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: OnTapOpacityContainer(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.3),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 200,
                      child: AutoSizeText(
                        'Relevant information',
                        style: GoogleFonts.mulish(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Swiper(
            controller: widget.swiperControllerCard,
            fade: 3.0,
            pagination: Dot_SwiperPaginationBuilder(
              true,
              color: Colors.black12,
              activeColor: Colors.black,
              size: 40,
              activeSize: 60,
              key: UniqueKey(),
              events: widget.events,
            ),
            physics: const NeverScrollableScrollPhysics(),
            onIndexChanged: (index) => setState(() {
              cardCurrentIndex = index;
            }),
            onTap: (index) {
              context
                  .push(ComplexRoutes.eventDetails([widget.events[index].id]));
            },
            itemBuilder: (context, index) {
              return EventCard(
                index: index,
                event: widget.events[index],
              );
            },
            itemCount: widget.events.length,
            itemWidth: MediaQuery.of(context).size.width * .8,
            itemHeight: MediaQuery.of(context).size.height * .7,
            layout: SwiperLayout.STACK,
          ),
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }

  void _listenDateController() => setState(() {});
}
