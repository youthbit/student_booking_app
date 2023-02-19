import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

import '../../../config/utils.dart';
import '../../../exceptions/app_exception.dart';
import '../../../main.dart';
import '../domain/news.dart';

class NewsRepository {
  final Dio _dio = getIt<Dio>();

  Future<List<News>> retrieveNews() async {
    late final Response<List> response;
    try {
      response = await _dio.get<List>('/news/');
    } on DioError catch (e) {
      print(e);
      throw const AppException.someErrorOccurred();
    }
    if (response.data == null) {
      throw const AppException.someErrorOccurred();
    }

    return (response.data as List)
        .map((dynamic e) => News.fromJson(e as ResponseJson))
        .toList();
  }
}

final newsRepositoryProvider =
Provider((ref) => NewsRepository());

final newsProvider = FutureProvider<List<News>>((ref) {
  final dormitoriesRepository = ref.watch(newsRepositoryProvider);
  return dormitoriesRepository.retrieveNews();
});
