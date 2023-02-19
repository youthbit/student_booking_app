import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_point_tab_bar/pointTabIndicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../config/general/on_tap_opacity_container.dart';
import '../../config/utils.dart';
import '../../generated/locale_keys.g.dart';
import '../authentication/data/auth_repository.dart';
import '../authentication/domain/user.dart';
import 'avatars_data.dart';
import 'avatars_repository.dart';
import 'domain/avatar.dart';
import 'domain/part.dart';
import 'domain/part_type.dart';
import 'widgets/animated_scroll_view_item.dart';
import 'widgets/avatar_view.dart';
import 'widgets/part_preview.dart';
import 'widgets/preview_header_delegate.dart';

final selectedTypeProvider =
    StateProvider.autoDispose<PartType>((ref) => PartType.body);

final partsProvider = FutureProvider.autoDispose((ref) async {
  final selectedType = ref.watch(selectedTypeProvider);
  final avatarsRepository = ref.watch(avatarsRepositoryProvider);

  PictureProvider.cache.clear();

  final paths = await avatarsRepository.listPartsFor(selectedType);
  return Future.wait(paths.map(Part.load));
});

final avatarEditorProvider =
    ChangeNotifierProvider.autoDispose<AvatarNotifier>((ref) {
  final avatar = ref.watch(avatarProvider.future);
  final notifier = AvatarNotifier();

  avatar.then(notifier.updateAvatar);

  return notifier;
});

final selectedColorsProvider =
    avatarEditorProvider.select((editor) => editor.colors);

class AvatarsCreatorScreen extends StatelessWidget {
  const AvatarsCreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final avatar = ref.watch(avatarEditorProvider);
          if (!avatar.loaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return child!;
        },
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: PreviewHeaderDelegate(
                maxExtent: MediaQuery.of(context).size.height * 0.5,
                minExtent: MediaQuery.of(context).size.height * 0.3,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.maybePop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  Consumer(
                    builder: (context, ref, child) => TextButton(
                      onPressed: () {
                        final avatar = ref.read(avatarEditorProvider);
                        final user =
                            ref.read(authRepositoryProvider).currentUser;

                        if (user is! User) {
                          return;
                        }

                        ref
                            .read(avatarsRepositoryProvider)
                            .saveUserAvatar(user, avatar)
                            .then((value) {
                          ref.invalidate(avatarProvider);
                          context.maybePop();
                        });
                      },
                      child: Text(
                        LocaleKeys.avatarCreatorViewSaveBtn.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
                builder: (width, height) => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 1000),
                  switchInCurve: Curves.easeOutCirc,
                  switchOutCurve: Curves.easeInCirc,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final editor = ref.watch(avatarEditorProvider);
                      final avatar = ref.watch(renderedAvatarProvider(editor));
                      final selectedColors = ref.watch(selectedColorsProvider);

                      return avatar.when(
                        skipLoadingOnRefresh: true,
                        skipLoadingOnReload: true,
                        data: (avatar) {
                          return AvatarView(
                            key: ValueKey(avatar!.key),
                            width: height * 0.7,
                            height: height * 0.7,
                            avatar: avatar,
                          );
                        },
                        error: (err, stack) => AvatarLoader(
                          key: UniqueKey(),
                          width: height * 0.7,
                          height: height * 0.7,
                          backgroundColor: Color(
                            selectedColors.background,
                          ),
                        ),
                        loading: () => AvatarLoader(
                          key: UniqueKey(),
                          width: height * 0.7,
                          height: height * 0.7,
                          backgroundColor: Color(
                            selectedColors.background,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const PartsTabBar(),
            const ColorsTabBar(),
            SliverPadding(
              padding: const EdgeInsets.all(25.0),
              sliver: Consumer(
                builder: (context, ref, child) {
                  final parts = ref.watch(partsProvider);
                  final selectedColors = ref.watch(selectedColorsProvider);
                  final selectedType = ref.watch(selectedTypeProvider);

                  return parts.when(
                    data: (parts) => SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      itemCount: parts.length,
                      itemBuilder: (ctx, i) {
                        final svg = parts[i].applyColors(selectedColors);

                        return AnimatedScrollViewItem(
                          child: OnTapOpacityContainer(
                            key: ValueKey(svg),
                            child: PartPreview(
                              part: Part(
                                path: parts[i].path,
                                picture: svg,
                              ),
                              partType: selectedType,
                              partColor: Color(selectedColors[selectedType]!),
                              backgroundColor:
                                  Color(selectedColors[PartType.background]!),
                            ),
                            onTap: () {
                              ref
                                  .read(avatarEditorProvider.notifier)
                                  .updatePart(selectedType, parts[i]);
                            },
                          ),
                        );
                      },
                    ),
                    loading: () => const SliverToBoxAdapter(
                      child: Center(
                        child: SizedBox(
                          width: 80.0,
                          height: 80.0,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    error: (err, stack) => const SliverToBoxAdapter(
                      child: Center(
                        child: SizedBox(
                          width: 80.0,
                          height: 80.0,
                          child: Icon(Icons.error_outline),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PartsTabBar extends ConsumerStatefulWidget {
  const PartsTabBar({
    super.key,
  });

  @override
  ConsumerState<PartsTabBar> createState() => _PartsTabBarState();
}

class _PartsTabBarState extends ConsumerState<PartsTabBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: PartType.values.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) return;

      final newPartType = PartType.values[tabController.index];
      ref.read(selectedTypeProvider.notifier).state = newPartType;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      sliver: SliverToBoxAdapter(
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          padding: const EdgeInsets.symmetric(horizontal: 200.0),
          labelPadding: const EdgeInsets.symmetric(horizontal: 50.0),
          indicator: const PointTabIndicator(
            insets: EdgeInsets.only(bottom: 6),
            color: Colors.cyan,
          ),
          tabs: PartType.values
              .map(
                (text) => SizedBox(
                  height: 40.0,
                  child: Text(
                    text.title,
                    maxLines: 1,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class ColorsTabBar extends ConsumerStatefulWidget {
  const ColorsTabBar({
    super.key,
  });

  @override
  ConsumerState<ColorsTabBar> createState() => _ColorsTabBarState();
}

class _ColorsTabBarState extends ConsumerState<ColorsTabBar>
    with TickerProviderStateMixin {
  late TabController tabController;
  late List<int> _availableColors;

  @override
  void initState() {
    super.initState();

    final selectedType = ref.read(selectedTypeProvider);
    final selectedColors = ref.read(selectedColorsProvider);

    _availableColors = listColors(selectedType);

    tabController = TabController(
      length: _availableColors.length,
      initialIndex: _availableColors.indexOf(selectedColors[selectedType]!),
      vsync: this,
    );
    tabController.addListener(_tabListener);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedColors = ref.watch(selectedColorsProvider);
    final selectedType = ref.watch(selectedTypeProvider);

    ref.listen(selectedTypeProvider, (previous, next) {
      _availableColors = listColors(next);

      tabController = TabController(
        length: _availableColors.length,
        initialIndex: _availableColors.indexOf(selectedColors[next]!),
        vsync: this,
      );
      tabController.addListener(_tabListener);
    });

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 60.0,
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          indicator: const BoxDecoration(),
          tabs: _availableColors.map((color) {
            return Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: selectedColors[selectedType] == color
                      ? Color(color)
                      : Colors.transparent,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(color),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _tabListener() {
    if (!tabController.indexIsChanging) return;

    final selectedType = ref.read(selectedTypeProvider);
    ref
        .read(avatarEditorProvider.notifier)
        .updateColor(selectedType, _availableColors[tabController.index]);
  }
}
