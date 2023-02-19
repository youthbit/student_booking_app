import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/general/on_tap_opacity_container.dart';
import '../../routing/router_spec.dart';
import '../application/onboarding_service.dart';
import '../widgets/line_painter.dart';
import '../widgets/ray_painter.dart';
import '../widgets/zigzag.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * .6,
              child: CustomPaint(
                painter: ShapePainter(),
                child: Container(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: AdvancedLine(
                    direction: Axis.horizontal,
                    line: ZigzagLine(
                      angle: 100,
                      depth: MediaQuery.of(context).size.height * .03,
                    ),
                    paintDef: Paint()
                      ..strokeCap = StrokeCap.round
                      ..color = Colors.white
                      ..strokeWidth = 4.0
                      ..style = PaintingStyle.stroke,
                  ),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: SvgPicture.asset(
                        'assets/svg/star.svg',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * .2,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height * .2,
                        child: Transform.rotate(
                          angle: -pi / 4,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .03,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .05,
                        left: MediaQuery.of(context).size.width * .05,
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .12,
                        width: MediaQuery.of(context).size.height * .12,
                        child: SvgPicture.asset(
                          'assets/svg/star.svg',
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .26,
                  ),
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * .12,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .03,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: AutoSizeText(
                    'Ваше\nСобытие',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 54, color: Colors.white),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: AutoSizeText(
                    'Гайд\n2023',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 54, color: Colors.white),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: OnTapOpacityContainer(
                    onTap: state.isLoading
                        ? () {}
                        : () async {
                            await ref
                                .read(onboardingControllerProvider.notifier)
                                .completeOnboarding()
                                .then(
                              (value) {
                                if (!context.mounted) return;
                                context.goNamed(RouteSpec.homepage.name);
                              },
                            );
                          },
                    child: Container(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * .05,
                      ),
                      height: MediaQuery.of(context).size.height * .1,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C7DF7),
                        border: Border.all(
                          color: const Color(0xFF6C7DF7),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          AutoSizeText(
                            'Исследовать',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const Spacer(),
                          Transform.rotate(
                            angle: -pi / 4,
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.black,
                              size: MediaQuery.of(context).size.height * .05,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
