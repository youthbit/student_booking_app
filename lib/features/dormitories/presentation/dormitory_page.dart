import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../authentication/data/auth_repository.dart';
import '../../favorites/data/favorites_repository.dart';
import '../../routing/router_spec.dart';
import '../data/dormitories_repository.dart';
import '../domain/dormitory.dart';
import 'widgets/gmap_view.dart';
import 'widgets/room_card.dart';

final dormitoryProvider =
    FutureProvider.autoDispose.family<Dormitory, String>((ref, id) async {
  final dormitories = await ref.watch(dormitoriesProvider.future);

  return dormitories.firstWhere((dormitory) => dormitory.id == id);
});

class DormitoryPage extends ConsumerStatefulWidget {
  final String dormitoryId;

  const DormitoryPage({
    required this.dormitoryId,
    super.key,
  });

  @override
  ConsumerState<DormitoryPage> createState() => DormitoryPageState();
}

class DormitoryPageState extends ConsumerState<DormitoryPage> {
  int selectedRoomIndex = 0;
  bool inFavorites = false;

  @override
  void initState() {
    super.initState();

    ref
        .read(favoritesRepositoryProvider)
        .retrieveFavoritesDormitories(
          ref.read(authRepositoryProvider).currentUser,
        )
        .then((favoritesDormitories) {
      if (favoritesDormitories.contains(widget.dormitoryId)) {
        setState(() {
          inFavorites = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dormitory = ref.watch(dormitoryProvider(widget.dormitoryId));

    return Scaffold(
      body: dormitory.when(
        error: (error, stack) =>
            const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (dormitory) => Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    iconTheme: IconThemeData(
                      color: Theme.of(context).iconTheme.color,
                    ),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    title: Text(
                      dormitory.name,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          final authRepository =
                              ref.read(authRepositoryProvider);
                          final favoritesProvider =
                              ref.read(favoritesRepositoryProvider);

                          if (!inFavorites) {
                            favoritesProvider
                                .addDormitoryToFavorites(
                              authRepository.currentUser,
                              dormitory.id,
                            )
                                .then((isSuccess) {
                              if (isSuccess) {
                                setState(() {
                                  inFavorites = true;
                                });
                              }
                            });
                          } else {
                            favoritesProvider
                                .removeDormitoryFromFavorites(
                              authRepository.currentUser,
                              dormitory.id,
                            )
                                .then((isSuccess) {
                              if (isSuccess) {
                                setState(() {
                                  inFavorites = false;
                                });
                              }
                            });
                          }
                        },
                        icon: Icon(
                          inFavorites
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                        ),
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10.0,
                        ),
                        itemCount: dormitory.photos.length,
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: CachedNetworkImage(
                            imageUrl: dormitory.photos[index],
                            placeholder: (context, url) => ColoredBox(
                              color: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .onBackground,
                              child: Container(
                                width: 100.0,
                                color: const Color(0xFF393939),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context)
                                        .buttonTheme
                                        .colorScheme!
                                        .background,
                                  ),
                                ),
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 25.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dormitory.name,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.place_outlined,
                                size: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .fontSize,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  dormitory.address,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: dormitory.priceMin != dormitory.priceMax
                                      ? '${dormitory.priceMin}–${dormitory.priceMax}₽'
                                      : '${dormitory.priceMin}₽',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                TextSpan(
                                  text: '/ ночь',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: IgnorePointer(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: GMapView(
                              markers: {
                                Marker(
                                  markerId: MarkerId(widget.dormitoryId),
                                  position:
                                      LatLng(dormitory.lat, dormitory.lng),
                                ),
                              },
                              initialPosition: CameraPosition(
                                zoom: 16.0,
                                target: LatLng(dormitory.lat, dormitory.lng),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 25.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Правила',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ExpandableText(
                            dormitory.description,
                            style: Theme.of(context).textTheme.headlineSmall,
                            maxLines: 10,
                            expandText: 'Подробнее',
                            linkColor: Colors.white,
                            collapseText: '',
                            collapseOnTextTap: true,
                            expandOnTextTap: true,
                            animation: true,
                            animationDuration:
                                const Duration(milliseconds: 500),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 5.0,
                      ),
                      child: Text(
                        'Комнаты',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: dormitory.rooms.length,
                        (context, index) => RoomCard(
                          dormitoryId: widget.dormitoryId,
                          room: dormitory.rooms[index],
                          selected: index == selectedRoomIndex,
                          onSelect: () {
                            setState(() {
                              selectedRoomIndex = index;
                            });
                          },
                          key: ValueKey(dormitory.rooms[index].id),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ColoredBox(
              color: Theme.of(context).iconTheme.color!,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: max(MediaQuery.of(context).viewPadding.bottom, 20.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dormitory.rooms[selectedRoomIndex].type,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).primaryIconTheme.color),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${dormitory.rooms[selectedRoomIndex].price}₽',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .primaryIconTheme
                                            .color),
                              ),
                              TextSpan(
                                text: '/ Ночь',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .primaryIconTheme
                                            .color),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushGuard(
                              ref,
                              ComplexRoutes.dormitoryBooking([
                                widget.dormitoryId,
                                dormitory.rooms[selectedRoomIndex].id,
                              ]),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            backgroundColor:
                                Theme.of(context).primaryIconTheme.color,
                            side: const BorderSide(width: 2),
                          ),
                          child: Text(
                            'ЗАБРОНИРОВАТЬ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: Theme.of(context).iconTheme.color),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
