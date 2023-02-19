import 'package:flutter/material.dart';

class PreviewHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget Function(double width, double height) builder;

  @override
  final double maxExtent;

  @override
  final double minExtent;

  final List<Widget> actions;

  PreviewHeaderDelegate({
    required this.builder,
    required this.actions,
    required this.maxExtent,
    required this.minExtent,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: builder(constraints.maxWidth, constraints.maxHeight),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: actions,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool shouldRebuild(PreviewHeaderDelegate oldDelegate) {
    return true;
  }
}
