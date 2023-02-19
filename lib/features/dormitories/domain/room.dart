import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';

part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String description,
    required String type,
    required int price,
    required List<String> photos,
  }) = _Room;

  factory Room.fromJson(Map<String, Object?> json) => _$RoomFromJson(json);
}
