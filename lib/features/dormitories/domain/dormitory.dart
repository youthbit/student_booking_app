import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'room.dart';

part 'dormitory.freezed.dart';
part 'dormitory.g.dart';

@freezed
class Dormitory with _$Dormitory implements ClusterItem {
  @override
  LatLng get location => LatLng(lat, lng);

  @override
  String get geohash =>
      Geohash.encode(location, codeLength: ClusterManager.precision);

  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory Dormitory({
    required String id,
    required String name,
    required String description,
    required String address,
    required double lat,
    required double lng,
    required List<Room> rooms,
    required List<String> photos,
    required int priceMin,
    required int priceMax,
  }) = _Dormitory;

  const Dormitory._();

  factory Dormitory.fromJson(Map<String, Object?> json) =>
      _$DormitoryFromJson(json);
}
