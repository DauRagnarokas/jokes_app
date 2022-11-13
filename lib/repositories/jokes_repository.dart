import 'package:dio/dio.dart';
import 'package:jokes_app/utils/suggestion_exception.dart';

import '../models/joke.dart';
import '../models/joke_category.dart';
import '../services/dio_service.dart';

class JokesRepository {
  final _service = DioService();

  Future<List<JokeCategory>> getCategories({CancelToken? cancelToken}) async =>
      _service.getCollection(
        path: 'https://api.chucknorris.io/jokes/categories',
        builder: (dynamic data) => JokeCategory.fromJson(data),
      );

  Future<Joke> getRandomJoke({CancelToken? cancelToken}) async =>
      _service.getSingle(
        path: 'https://api.chucknorris.io/jokes/random',
        builder: (Map<String, dynamic> data) => Joke.fromJson(data),
      );

  Future<Joke> getRandomCategoryJoke({
    required JokeCategory category,
    CancelToken? cancelToken,
  }) async {
    return _service.getSingle(
      path: 'https://api.chucknorris.io/jokes/random?category=${category.name}',
      builder: (Map<String, dynamic> data) => Joke.fromJson(data),
    );
  }

  Future<List<Joke>> searchJokes({
    String? query,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _service.getSingle(
        path: 'https://api.chucknorris.io/jokes/search?query=$query',
        builder: (Map<String, dynamic> data) {
          final List<Joke> items = [];
          data['result'].forEach(
            (element) => items.add(
              Joke.fromJson(element),
            ),
          );
          return items;
        },
      );
    } on DioError catch (e) {
      if (e.response != null) {
        throw InputException(message: e.response!.data['message']);
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
