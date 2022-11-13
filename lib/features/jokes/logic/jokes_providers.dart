import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../models/joke.dart';
import '../../../models/joke_category.dart';
import '../../../repositories/jokes_repository.dart';

final jokesRepositoryProvider = Provider<JokesRepository>((_) => JokesRepository());

final getJokeCategoriesProvider = FutureProvider<List<JokeCategory>>(
  (ref) async {
    final repository = ref.watch(jokesRepositoryProvider);
    final List<JokeCategory> items = await repository.getCategories();
    return items;
  },
);

final getRandomJokeProvider = FutureProvider.autoDispose<Joke>(
  (ref) async {
    final cancelToken = CancelToken();
    final repository = ref.watch(jokesRepositoryProvider);
    final item = await repository.getRandomJoke(cancelToken: cancelToken);
    ref.onDispose(() => cancelToken.cancel());
    return item;
  },
);

final getRandomJokeCategoryProvider = FutureProvider.autoDispose.family<Joke, JokeCategory>(
  (ref, category) async {
    final cancelToken = CancelToken();
    final repository = ref.watch(jokesRepositoryProvider);
    final item = await repository.getRandomCategoryJoke(category: category, cancelToken: cancelToken);
    ref.onDispose(() => cancelToken.cancel());
    return item;
  },
);

final searchJokesProvider = FutureProvider.autoDispose.family<List<Joke>, String?>(
  (ref, query) async {
    final cancelToken = CancelToken();
    final repository = ref.watch(jokesRepositoryProvider);
    final data = await repository.searchJokes(query: query, cancelToken: cancelToken);
    ref.onDispose(() => cancelToken.cancel());
    return data;
  },
);
