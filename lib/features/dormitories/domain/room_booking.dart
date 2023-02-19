import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_booking.freezed.dart';
part 'room_booking.g.dart';

@freezed
class RoomBookingPreview with _$RoomBookingPreview {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory RoomBookingPreview({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String dormitory,
    required String roomType,
    required int price,
    required int available,
  }) = _RoomBookingPreview;

  const RoomBookingPreview._();

  factory RoomBookingPreview.fromJson(Map<String, Object?> json) =>
      _$RoomBookingPreviewFromJson(json);
}
