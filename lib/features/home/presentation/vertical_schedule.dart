import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/general/on_tap_opacity_container.dart';
import '../../routing/router_spec.dart';
import '../domain/event.dart';
import 'widgets/date_picker_item.dart';
import 'widgets/event_card.dart';

class Dot_SwiperPaginationBuilder extends SwiperPlugin {
  final List<Event> events;

  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///Size of the dot when activate
  final double activeSize;

  ///Size of the dot
  final double size;

  /// Space between dots
  final double space;

  final Key key;
  final bool horizontal;

  const Dot_SwiperPaginationBuilder(
    this.horizontal, {
    required this.activeColor,
    required this.color,
    required this.key,
    required this.events,
    this.size: 10.0,
    this.activeSize: 10.0,
    this.space: 3.0,
  });

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    if (config.itemCount > 20) {
      print(
        "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation",
      );
    }
    Color activeColor = this.activeColor;
    Color color = this.color;

    if (activeColor == null || color == null) {
      ThemeData themeData = Theme.of(context);
      activeColor = this.activeColor ?? themeData.primaryColor;
      color = this.color ?? themeData.scaffoldBackgroundColor;
    }

    List<Widget> list = [];

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (var i = activeIndex; i < activeIndex + 5; i++) {
      var active = i == activeIndex;
      list.add(
        Container(
          height: 80,
          width: 80,
          key: Key('pagination_$i'),
          child: DatePickerItem(
            isSelected: active,
            day: events[i % itemCount].day,
            month: events[i % itemCount].month,
          ),
        ),
      );
    }

    if (!horizontal) {
      return Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      return Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }
  }
}

class VerticalSchedule extends ConsumerStatefulWidget {
  final SwiperController swiperControllerDate;
  final SwiperController swiperControllerCard;
  final List<Event> events;

  const VerticalSchedule({
    Key? key,
    required this.swiperControllerDate,
    required this.swiperControllerCard,
    required this.events,
  }) : super(key: key);

  @override
  ConsumerState<VerticalSchedule> createState() => _VerticalScheduleState();
}

class _VerticalScheduleState extends ConsumerState<VerticalSchedule>
    with TickerProviderStateMixin {
  late int dateCurrentIndex;
  late int realState;
  late int cardCurrentIndex;
  late bool selected;

  int guestsCount = 0;

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
            padding:
                const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 8.0),
            child: OnTapOpacityContainer(
              onTap: () {
                context.push(RouteSpec.news.path);
              },
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
                        'Полезная информация',
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
          flex: 5,
          child: Swiper(
            controller: widget.swiperControllerCard,
            fade: 3.0,
            pagination: Dot_SwiperPaginationBuilder(
              false,
              color: Colors.black12,
              activeColor: Colors.black,
              size: 40,
              activeSize: 60,
              key: UniqueKey(),
              events: widget.events,
            ),
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            viewportFraction: 3.0,
            onTap: (index) {
              context
                  .push(ComplexRoutes.eventDetails([widget.events[index].id]));
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 80),
                child: EventCard(
                  index: index,
                  event: widget.events[index],
                ),
              );
            },
            itemCount: widget.events.length,
            itemWidth: MediaQuery.of(context).size.width,
            itemHeight: MediaQuery.of(context).size.height * .35,
            layout: SwiperLayout.CUSTOM,
            customLayoutOption: CustomLayoutOption(
              startIndex: -3,
              stateCount: 5,
            )
              ..addScale([0.8, 0.8, .95, 1, 0.9], Alignment.center)
              ..addOpacity([0.0, 0.5, 0.7, 1.0, 0])
              ..addRotate([
                -45.0 / 180,
                45.0 / 180,
                -25.0 / 180,
                0.0 / 180,
                0.0,
              ])
              ..addTranslate(
                [
                  Offset(
                    50.0,
                    ((MediaQuery.of(context).size.width * .5) + (-100)),
                  ),
                  Offset(
                    50.0,
                    ((MediaQuery.of(context).size.width * .4) + (-100)),
                  ),
                  Offset(
                    -0.0,
                    ((MediaQuery.of(context).size.width * .17) + (-100)),
                  ),
                  const Offset(.0, -100),
                  const Offset(.0, -150.0),
                ],
              ),
          ),
        ),
      ],
    );
  }

  void _listenDateController() => setState(() {});
}
