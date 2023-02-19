import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../avatars/avatars_creator_view.dart';
import '../../dormitories/presentation/dormitories_page.dart';
import '../../game/screens/home/home_screen.dart';
import 'tabs/home_tab.dart';
import 'widgets/navigation_bar.dart';

class GeneralView extends ConsumerStatefulWidget {
  const GeneralView({
    super.key,
  });

  @override
  ConsumerState<GeneralView> createState() => _GeneralViewState();
}

class _GeneralViewState extends ConsumerState<GeneralView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    HomeScreen(),
    DormitoriesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: HomeNavigationBar(
        (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        _selectedIndex,
      ),
    );
  }
}
