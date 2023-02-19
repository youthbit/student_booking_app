import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../../authentication/data/auth_repository.dart';
import '../../../side_menu/side_menu.dart';
import '../../application/scheduler_service.dart';
import '../horizontal_schedule.dart';
import '../vertical_schedule.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({
    super.key,
  });

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab>
    with SingleTickerProviderStateMixin {
  late int dateCurrentIndex;
  late int realState;
  late int cardCurrentIndex;
  late bool selected;
  late SwiperController _swiperControllerDate;
  late SwiperController _swiperControllerCard;
  final menuStateKey = GlobalKey<SideMenuState>();

  @override
  void initState() {
    super.initState();
    dateCurrentIndex = 2;
    selected = false;
    cardCurrentIndex = 2;
    realState = 0;
    _swiperControllerDate = SwiperController();
    //..addListener(_listenDateController);
    _swiperControllerCard = SwiperController();
    //..addListener(_listenDateController);
  }

  @override
  Widget build(BuildContext context) {
    final scheduleService = ref.watch(scheduleProvider);
    final authRepository = ref.watch(authRepositoryProvider);
    return SideMenuScreen(
        menuStateKey: menuStateKey,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.centerLeft,
              colors: [
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColorDark,
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: AutoSizeText(
                          'Привет,\n${(authRepository.currentUser?.name ?? 'Друг').toUpperCase()}!',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(fontSize: 54),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: 54,
                            width: 54,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                if (!context.mounted) return;
                                // context.push(RouteSpec.settings.path);
                                SideMenuScreen.toggleMenu(menuStateKey);
                              },
                              icon: Icon(
                                Icons.settings,
                                color: Theme.of(context).primaryIconTheme.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 6, bottom: 8),
                  child: SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    child: AutoSizeText(
                      'Какие планы сегодня:',
                      style: Theme.of(context).textTheme.headlineMedium,
                      maxLines: 1,
                    ),
                  ),
                ),
                scheduleService.when(
                  data: (data) {
                    return Expanded(
                      flex: 10,
                      child: MediaQuery.of(context).size.height < 800
                          ? HorizontalSchedule(
                              events: data,
                              swiperControllerDate: _swiperControllerDate,
                              swiperControllerCard: _swiperControllerCard,
                            )
                          : VerticalSchedule(
                              events: data,
                              swiperControllerDate: _swiperControllerDate,
                              swiperControllerCard: _swiperControllerCard,
                            ),
                    );
                  },
                  loading: () => const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (error, e) => Center(
                    child: Text(
                      'Ошибка ${error.toString()}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _listenDateController() => setState(() {});
}
