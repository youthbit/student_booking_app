import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/dormitories_repository.dart';
import '../../domain/dormitory.dart';
import '../map_page.dart';
import 'dormitory_card.dart';
import 'radar_widget.dart';

final searchRadiusProvider = StateProvider<double>((ref) => 100);

final filteredDormitories =
    FutureProvider.autoDispose<List<Dormitory>>((ref) async {
  final dormitories = await ref.watch(dormitoriesProvider.future);
  final userPosition = await ref.watch(userPositionProvider.future);
  final searchRadius = ref.watch(searchRadiusProvider);

  return dormitories
      .where(
        (dormitory) =>
            Geolocator.distanceBetween(
              dormitory.lat,
              dormitory.lng,
              userPosition.latitude,
              userPosition.longitude,
            ) <=
            searchRadius * 1000,
      )
      .toList();
});

class SearchSheet extends ConsumerStatefulWidget {
  const SearchSheet({
    super.key,
  });

  @override
  ConsumerState<SearchSheet> createState() => SearchSheetState();
}

class SearchSheetState extends ConsumerState<SearchSheet> {
  late DraggableScrollableController _controller;
  double minSize = 0;

  @override
  void initState() {
    super.initState();
    _controller = DraggableScrollableController();
  }

  @override
  Widget build(BuildContext context) {
    final searchRadius = ref.watch(searchRadiusProvider);

    final mediaQuery = MediaQuery.of(context);
    final viewHeight = mediaQuery.size.height -
        (mediaQuery.viewInsets.vertical - mediaQuery.viewPadding.vertical);

    final maxChildSize =
        (viewHeight - mediaQuery.viewPadding.top - 68) / viewHeight;

    final minChildSize = (minSize + 110) / viewHeight;

    return DraggableScrollableSheet(
      controller: _controller,
      maxChildSize: maxChildSize,
      snap: true,
      snapSizes: [minChildSize, maxChildSize],
      initialChildSize: minChildSize,
      minChildSize: minChildSize,
      builder: (context, scrollController) => DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: MeasureSize(
                onChange: (newSize) {
                  setState(() {
                    minSize = newSize.height;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 25.0, top: 10.0
                      // vertical: 25.0,
                      ),
                  child: Column(
                    children: [
                      const RadarWidget(),
                      Text(
                        'Поиск ближайших общежитий',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Поможет найти подходящее общежитие ',
                            ),
                            TextSpan(
                              text: '$searchRadius',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: Theme.of(context).iconTheme.color),
                            ),
                            const TextSpan(text: ' Километров'),
                          ],
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        '~$searchRadius km',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Slider(
                        value: searchRadius,
                        min: 100,
                        max: 1000,
                        divisions: 18,
                        activeColor: Theme.of(context).iconTheme.color,
                        inactiveColor: Theme.of(context).iconTheme.color,
                        onChanged: (double value) {
                          ref.read(searchRadiusProvider.notifier).state = value;
                        },
                      ),
                      Row(
                        children: [
                          Text(
                            '100km',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const Spacer(),
                          Text(
                            '1000km',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 90.0,
              ),
              sliver: Consumer(
                builder: (context, ref, child) {
                  final searchResults = ref.watch(filteredDormitories);

                  return searchResults.when(
                    data: (searchResults) => SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => DormitoryCard(searchResults[index]),
                        childCount: searchResults.length,
                      ),
                    ),
                    error: (error, stack) => const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    loading: () {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
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

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    var newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant MeasureSizeRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}
