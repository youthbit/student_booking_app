import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'map_page.dart';
import 'widgets/search_view.dart';

class DormitoriesPage extends ConsumerStatefulWidget {
  const DormitoriesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DormitoriesPage> createState() => DormitoriesPageState();
}

class DormitoriesPageState extends ConsumerState<DormitoriesPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            const MapPage(
              key: PageStorageKey('map'),
            ),
            ColoredBox(
              color: Theme.of(context).colorScheme.tertiary,
              child: const SafeArea(
                bottom: false,
                key: PageStorageKey('list'),
                child: Padding(
                  padding: EdgeInsets.only(top: 68.0),
                  child: SearchView(
                    bottomPadding: 90.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 48,
              child: DefaultTextStyle.merge(
                style: TextStyle(
                  color: Theme.of(context).buttonTheme.colorScheme?.background,
                ),
                child: CustomSlidingSegmentedControl<int>(
                  initialValue: 1,
                  isStretch: true,
                  height: 48,
                  innerPadding: EdgeInsets.zero,
                  children: const {
                    1: Text('Map'),
                    2: Text('List'),
                  },
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  thumbDecoration: BoxDecoration(
                    color: Theme.of(context).buttonTheme.colorScheme?.onBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInToLinear,
                  onValueChanged: (v) {
                    _pageController.animateToPage(
                      v - 1,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
