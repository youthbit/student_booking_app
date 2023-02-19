import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'event.freezed.dart';

part 'event.g.dart';

@Collection(ignore: {'copyWith'})
@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String type,
    required String name,
    required String description,
    required String price,
    required List<String> photos,
    required String day,
    required String month,
  }) = _Event;

  const Event._();

  Id get isarId => fastHash(id.toString());

  factory Event.fromJson(Map<String, Object?> json) => _$EventFromJson(json);
}

int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}
