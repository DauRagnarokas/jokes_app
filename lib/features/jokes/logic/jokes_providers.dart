import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jokes_app/services/dio_service.dart';
import '../../../models/joke.dart';
import '../../../models/joke_category.dart';
import '../../../utils/input_exception.dart';


final getJokeCategoriesProvider = FutureProvider<List<JokeCategory>>(
      (ref) => ref.read(dioProvider).getCollection(
    path: 'categories',
    builder: (dynamic data) => JokeCategory.fromJson(data),
  ),
);

final getRandomJokeProvider = FutureProvider.autoDispose<Joke>(
(ref) async => ref.read(dioProvider).getSingle(
    path: 'random',
    builder: (Map<String, dynamic> data) => Joke.fromJson(data),
  ),
);

final getRandomJokeCategoryProvider = FutureProvider.autoDispose.family<Joke, JokeCategory>(
  (ref, category) async => ref.read(dioProvider).getSingle(
    path: 'random?category=${category.name}',
    builder: (Map<String, dynamic> data) => Joke.fromJson(data),
  ),
);

final searchJokesProvider = FutureProvider.autoDispose.family<List<Joke>, String?>(
  (ref, query) async {
    try {
      return await ref.read(dioProvider).getSingle(
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

  },
);
