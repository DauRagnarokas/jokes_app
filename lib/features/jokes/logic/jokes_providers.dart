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
    final repository = ref.watch(jokesRepositoryProvider);
    final item = await repository.getRandomJoke();
    return item;
  },
);

final getRandomJokeCategoryProvider = FutureProvider.autoDispose.family<Joke, JokeCategory>(
  (ref, category) async {
    final repository = ref.watch(jokesRepositoryProvider);
    final item = await repository.getRandomCategoryJoke(category: category);
    return item;
  },
);

final searchJokesProvider = FutureProvider.autoDispose.family<List<Joke>, String?>(
  (ref, query) async {
    final repository = ref.watch(jokesRepositoryProvider);
    final data = await repository.searchJokes(query: query);
    return data;
  },
);
