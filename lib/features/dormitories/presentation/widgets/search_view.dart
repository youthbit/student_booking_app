import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dormitories_repository.dart';
import '../../data/room_type.dart';
import '../../domain/dormitory.dart';
import 'dormitory_card.dart';

final searchTextProvider = StateProvider<String>((ref) => '');

final selectedFiltersProvider =
    StateNotifierProvider<RoomsTypeNotifier, List<RoomType>>(
  (ref) => RoomsTypeNotifier(),
);

final filteredDormitories =
    FutureProvider.autoDispose<List<Dormitory>>((ref) async {
  final dormitories = await ref.watch(dormitoriesProvider.future);
  final searchText = ref.watch(searchTextProvider);
  final selectedFilters = ref.watch(selectedFiltersProvider);

  return dormitories
      .where((dormitory) => dormitory.name.toLowerCase().contains(searchText))
      .filterByRooms(selectedFilters)
      .toList();
});

class SearchView extends StatefulWidget {
  final ScrollController? scrollController;
  final void Function()? onFocus;
  final double? bottomPadding;

  const SearchView({
    this.scrollController,
    this.onFocus,
    this.bottomPadding,
    super.key,
  });

  static double headerMaxHeight = 178.0;
  static double headerMinHeight = 88.0;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _focus = FocusNode();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focus.addListener(() {
      if (_focus.hasFocus) {
        widget.onFocus?.call();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
      ),
      child: CustomScrollView(
        controller: widget.scrollController,
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SearchHeaderDelegate(
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          _controller
                            ..text = ref.read(searchTextProvider)
                            ..selection = TextSelection.collapsed(
                              offset: _controller.text.length,
                            );
                          ref.listen(searchTextProvider, (previous, next) {
                            if (!_focus.hasFocus) {
                              _controller
                                ..text = next
                                ..selection = TextSelection.collapsed(
                                  offset: next.length,
                                );
                            }
                          });

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              // focusNode: _focus,
                              controller: _controller,
                              focusNode: _focus,
                              onChanged: (newText) {
                                ref.read(searchTextProvider.notifier).state =
                                    newText;
                              },
                              decoration: InputDecoration(
                                hintText: 'Поиск',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(3.0),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  borderSide: BorderSide.none,
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final selectedFilters =
                              ref.watch(selectedFiltersProvider);

                          return SizedBox(
                            height: 50.0,
                            child: ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              scrollDirection: Axis.horizontal,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                width: 15.0,
                              ),
                              itemCount: RoomType.values.length,
                              itemBuilder: (context, index) {
                                final roomType = RoomType.values[index];

                                return InkWell(
                                  onTap: () {
                                    ref
                                        .read(selectedFiltersProvider.notifier)
                                        .toggle(roomType);
                                  },
                                  child: SizedBox(
                                    width: 48.0,
                                    height: 48.0,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        color:
                                            selectedFilters.contains(roomType)
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                      child: Center(
                                        child: Icon(roomType.icon),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: widget.bottomPadding ?? 0.0,
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
    );
  }
}

class SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  const SearchHeaderDelegate(this.child);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => minExtent;

  @override
  double get minExtent => SearchView.headerMaxHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
