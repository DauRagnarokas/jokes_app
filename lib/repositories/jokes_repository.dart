import 'package:dio/dio.dart';
import 'package:jokes_app/utils/input_exception.dart';

import '../models/joke.dart';
import '../models/joke_category.dart';
import '../services/dio_service.dart';

class JokesRepository {
  final _service = DioService();

  Future<List<JokeCategory>> getCategories() async =>
      _service.getCollection(
        path: 'categories',
        builder: (dynamic data) => JokeCategory.fromJson(data),
      );

  Future<Joke> getRandomJoke() async =>
      _service.getSingle(
        path: 'random',
        builder: (Map<String, dynamic> data) => Joke.fromJson(data),
      );

  Future<Joke> getRandomCategoryJoke({
    required JokeCategory category,
  }) async {
    return _service.getSingle(
      path: 'random?category=${category.name}',
      builder: (Map<String, dynamic> data) => Joke.fromJson(data),
    );
  }

  Future<List<Joke>> searchJokes({
    String? query,
  }) async {
    try {
      return await _service.getSingle(
        path: 'search?query=$query',
        builder: (Map<String, dynamic> data) {
          final List<Joke> items = [
            for (final item in data['result']) Joke.fromJson(item)
          ];
          return items;
        },
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {
        throw InputException.fromDioMessage(e);
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
