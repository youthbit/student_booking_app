import 'package:freezed_annotation/freezed_annotation.dart';

part 'news.freezed.dart';
part 'news.g.dart';

@freezed
class News with _$News {
  const factory News({
    required String id,
    required String title,
    required String cover,
    required String content,
  }) = _News;

  const News._();

  factory News.fromJson(Map<String, Object?> json) =>
      _$NewsFromJson(json);
}
