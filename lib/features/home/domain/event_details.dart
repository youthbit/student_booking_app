import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_details.freezed.dart';

part 'event_details.g.dart';

@freezed
class EventDetails with _$EventDetails {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory EventDetails({
    required String id,
    required String type,
    required String description,
    required String name,
    required int price,
    required List<String> photos,
    required List<String> videos,
  }) = _EventDetails;

  const EventDetails._();

  factory EventDetails.fromJson(Map<String, Object?> json) =>
      _$EventDetailsFromJson(json);
}
