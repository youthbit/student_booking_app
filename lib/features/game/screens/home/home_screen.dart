import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../authentication/data/auth_repository.dart';
import '../../../avatars/avatars_repository.dart';
import '../../../avatars/domain/avatar.dart';
import '../../../avatars/widgets/avatar_view.dart';
import '../../shared/consts.dart';
import '../../shared/widgets/paralax.dart';
import 'subscreens/benefits_subscreen.dart';
import 'subscreens/urban_planners_subscreen.dart';

final _renderedAvatarProvider =
FutureProvider.autoDispose<RenderedAvatar?>((ref) async {
  final avatar = await ref.watch(avatarProvider.future);

  final renderedAvatarValue = ref.watch(renderedAvatarProvider(avatar).future);
  return await renderedAvatarValue;
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController controller = ScrollController();
  final bool _disabled3D = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = ref.watch(authRepositoryProvider);
    final avatar = ref.watch(_renderedAvatarProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0), // here the desired height
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * .05),
                height: MediaQuery.of(context).size.height * .2,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(50),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24),
                child: Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.ac_unit_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .16,
                  right: 40,
                  left: 40,
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: MediaQuery.of(context).size.height * .08,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(
                          0,
                          3,
                        ), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      avatar.when(
                        data: (avatar) {
                          return avatar == null
                              ? const Icon(CupertinoIcons.person)
                              : AvatarView(avatar: avatar, width: 40, height: 40);
                        },
                        error: (_, __) {
                          return const Icon(Icons.error);
                        },
                        loading: () {
                          return const Icon(Icons.loop);
                        },
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authRepository.currentUser?.name ?? 'Anon',
                              style: Theme.of(context).textTheme.headlineSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              'Level 99',
                              style: Theme.of(context).textTheme.headlineSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ParallaxScroll(
          controller: controller,
          parallaxBackgroundChildren:
              Theme.of(context).brightness == Brightness.light
                  ? _buildLightParallaxElements()
                  : _buildDarkParallaxElements(),
          parallaxForegroundChildren: [
            ParallaxElement(
              child: SizedBox(
                height: 15000,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: 150,
                      left: MediaQuery.of(context).size.width * 0.7,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/achievements/achievement_0.png',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 450,
                      left: MediaQuery.of(context).size.width * 0.1,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/achievements/achievement_1.png',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 850,
                      left: MediaQuery.of(context).size.width * 0.55,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/achievements/achievement_3.png',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 1200,
                      left: MediaQuery.of(context).size.width * 0.5,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/achievements/achievement_5.png',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 1500,
                      left: MediaQuery.of(context).size.width * 0.7,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/achievements/achievement_6.png',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 1750,
                      left: MediaQuery.of(context).size.width * 0.03,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/achievements/achievement_7.png',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2100,
                      left: MediaQuery.of(context).size.width * 0.6,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/achievements/achievement_8.png',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2400,
                      left: MediaQuery.of(context).size.width * 0.4,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/achievements/achievement_9.png',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2700,
                      left: MediaQuery.of(context).size.width * 0.55,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/achievements/achievement_10.png',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 3000,
                      left: MediaQuery.of(context).size.width * 0.3,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/achievements/achievement_11.png',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
          children: [
            UrbanPlannersSubscreen(controller: controller),
            BenefitsSubscreen(controller: controller),
          ],
        ),
      ),
    );
  }

  List<ParallaxElement> _buildDarkParallaxElements() {
    return [
      ParallaxElement(
        scrollDelay: const Duration(milliseconds: 230),
        child: ParallaxSvgBackground(
          disableDeepEffect: true,
          disableShadow: true,
          settings: ParallaxBackgroundSettings.predefined(),
          svgAssetName: 'assets/svg/background_icons.svg',
          translationOffset: Consts.svgBackgroundIconsOffst,
        ),
      ),
      ParallaxElement(
        scrollDelay: const Duration(milliseconds: 230),
        child: ParallaxSvgBackground(
          disableDeepEffect: _disabled3D,
          settings: ParallaxBackgroundSettings.predefined(),
          svgAssetName: 'assets/svg/dark/layer3.svg',
          translationOffset: Consts.svgLayersOffset,
        ),
      ),
      ParallaxElement(
        scrollDelay: const Duration(milliseconds: 150),
        child: ParallaxSvgBackground(
          disableDeepEffect: _disabled3D,
          settings: ParallaxBackgroundSettings.predefined(),
          svgAssetName: 'assets/svg/dark/layer2.svg',
          translationOffset: Consts.svgLayersOffset,
        ),
      ),
      ParallaxElement(
        scrollDelay: const Duration(milliseconds: 40),
        child: ParallaxSvgBackground(
          disableDeepEffect: _disabled3D,
          settings: ParallaxBackgroundSettings.predefined(),
          svgAssetName: 'assets/svg/dark/layer1.svg',
          translationOffset: Consts.svgLayersOffset,
        ),
      ),
      ParallaxElement(
        scrollDelay: const Duration(milliseconds: 40),
        child: ParallaxSvgBackground(
          disableDeepEffect: true,
          disableShadow: true,
          settings: ParallaxBackgroundSettings.predefined(),
          svgAssetName: 'assets/svg/dark/layer4.svg',
          translationOffset: Consts.svgLayersOffset,
        ),
      ),
    ];
  }

  List<ParallaxElement> _buildLightParallaxElements() {
    return [
      ParallaxElement(
        scrollDelay: const Duration(milliseconds: 230),
        child: ParallaxSvgBackground(
          disableDeepEffect: true,
          disableShadow: true,
          settings: ParallaxBackgroundSettings.predefined(),
          svgAssetName: 'assets/svg/background_icons.svg',
          translationOffset: Consts.svgBackgroundIconsOffst,
        ),
      ),
      ParallaxElement(
        scrollDelay: const Duration(milliseconds: 230),
        child: ParallaxSvgBackground(
          disableDeepEffect: _disabled3D,
          settings: ParallaxBackgroundSettings.predefined(),
          svgAssetName: 'assets/svg/light/layer3.svg',
          translationOffset: Consts.svgLayersOffset,
        ),
      ),
      ParallaxElement(
        scrollDelay: const Duration(milliseconds: 150),
        child: ParallaxSvgBackground(
          disableDeepEffect: _disabled3D,
          settings: ParallaxBackgroundSettings.predefined(),
          svgAssetName: 'assets/svg/light/layer2.svg',
          translationOffset: Consts.svgLayersOffset,
        ),
      ),
      ParallaxElement(
        scrollDelay: const Duration(milliseconds: 40),
        child: ParallaxSvgBackground(
          disableDeepEffect: _disabled3D,
          settings: ParallaxBackgroundSettings.predefined(),
          svgAssetName: 'assets/svg/light/layer1.svg',
          translationOffset: Consts.svgLayersOffset,
        ),
      ),
      ParallaxElement(
        scrollDelay: const Duration(milliseconds: 40),
        child: ParallaxSvgBackground(
          disableDeepEffect: true,
          disableShadow: true,
          settings: ParallaxBackgroundSettings.predefined(),
          svgAssetName: 'assets/svg/light/layer4.svg',
          translationOffset: Consts.svgLayersOffset,
        ),
      ),
    ];
  }
}
