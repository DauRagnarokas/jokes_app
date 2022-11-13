import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jokes_app/features/categories/logic/random_joke_category_states.dart';

import '../../../models/joke.dart';
import '../../../models/joke_category.dart';
import '../../jokes/logic/jokes_providers.dart';

final randomJokeCategoryStateProvider = StateNotifierProvider.family<
    _RandomJokeCategoryButtonNotifier, RandomJokeCategoryState, JokeCategory>(
  (ref, category) => _RandomJokeCategoryButtonNotifier(ref.read, category),
);

class _RandomJokeCategoryButtonNotifier extends StateNotifier<RandomJokeCategoryState> {
  _RandomJokeCategoryButtonNotifier(this.read, this.category) : super(const RandomJokeCategoryState());

  final Function(ProviderListenable) read;
  final JokeCategory category;

  request({
    Function(Joke)? callback,
  }) async {
    state = const RandomJokeCategoryState.loading();
    final Joke data = await read(getRandomJokeCategoryProvider(category).future);
    state = RandomJokeCategoryState.data(data);
    callback?.call(data);
  }
}
