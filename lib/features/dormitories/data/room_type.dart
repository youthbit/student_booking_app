import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/dormitory.dart';

enum RoomType {
  onePlace(
    icon: Icons.one_k,
    firstFilter: '1-но местный номер',
    secondFilter: '1-но местный номер',
    maxQuantity: 1,
  ),
  twoPlaces(
    icon: Icons.two_k,
    firstFilter: '2-х местная квартира',
    secondFilter: '2-х местный номер',
    maxQuantity: 2,
  ),
  threePlaces(
    icon: Icons.three_k,
    firstFilter: '3-х местная квартира',
    secondFilter: '3-х местный номер',
    maxQuantity: 3,
  ),
  fourPlaces(
    icon: Icons.four_k,
    firstFilter: '4-х местная квартира',
    secondFilter: '4-х местный номер',
    maxQuantity: 4,
  ),
  fivePlaces(
      icon: Icons.five_k,
      firstFilter: '5-ти местная квартира',
      secondFilter: '5-ти местный номер',
      maxQuantity: 5),
  sixPlaces(
    icon: Icons.six_k,
    firstFilter: '6-ти местная квартира',
    secondFilter: '6-ти местный номер',
    maxQuantity: 6,
  ),
  nonTypical(
    icon: Icons.seven_k_plus,
    firstFilter: 'Не типовое размещение',
    secondFilter: 'Не типовое размещение',
    maxQuantity: 9999999999, // м как вкусно без инфинити то
  );

  const RoomType({
    required this.icon,
    required this.firstFilter,
    required this.secondFilter,
    required this.maxQuantity,
  });

  final IconData icon;
  final String firstFilter;
  final String secondFilter;
  final int maxQuantity;

  static RoomType fromString(String string) => RoomType.values.firstWhere(
        (element) =>
            element.firstFilter == string || element.secondFilter == string,
      );
}

extension RoomTypesToString on List<RoomType> {
  List<String> toStringList() {
    return expand((roomType) => [roomType.firstFilter, roomType.secondFilter])
        .toList();
  }
}

extension FilterByRoomType on Iterable<Dormitory> {
  filterByRooms(List<RoomType> roomTypes) {
    final roomTypesString = roomTypes.toStringList();

    return where(
      (dormitory) =>
          dormitory.rooms.any((room) => roomTypesString.contains(room.type)),
    );
  }
}

class RoomsTypeNotifier extends StateNotifier<List<RoomType>> {
  RoomsTypeNotifier() : super(RoomType.values);

  void toggle(RoomType roomType) {
    if (state.contains(roomType)) {
      state = state.where((type) => type != roomType).toList();
    } else {
      state = [...state, roomType];
    }
  }
}
