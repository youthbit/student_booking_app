import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeNavigationBar extends StatelessWidget {
  final dynamic Function(int)? onTap;
  final int selectedIndex;

  const HomeNavigationBar(this.onTap, this.selectedIndex, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomNavigationBar(
        elevation: 20.0,
        selectedColor: Theme.of(context).primaryColor,
        strokeColor:Theme.of(context).primaryColor,
        unSelectedColor: Theme.of(context).iconTheme.color,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const Radius.circular(20.0),
        items: [
          CustomNavigationBarItem(
            icon: const Icon(Icons.home),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.lightbulb_outline),
          ),
          CustomNavigationBarItem(
            icon: const Icon(
              Icons.map,
            ),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) => onTap?.call(index),
      ),
    );
  }
}
