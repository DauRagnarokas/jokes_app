import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jokes_app/features/random_joke_button/logic/random_joke_states.dart';
import '../../../models/joke.dart';
import '../../jokes/logic/jokes_providers.dart';

final randomJokeStateProvider =
    StateNotifierProvider.autoDispose<_RandomJokeButtonNotifier, RandomJokeState>(
        (ref) => _RandomJokeButtonNotifier(ref.read));

class _RandomJokeButtonNotifier extends StateNotifier<RandomJokeState> {
  _RandomJokeButtonNotifier(this.read) : super(const RandomJokeState());

  final Function(ProviderListenable) read;

  request({Function(Joke)? callback}) async {
    state = const RandomJokeState.loading();
    final Joke data = await read(getRandomJokeProvider.future);
    state = RandomJokeState.data(data);
    callback?.call(data);
  }
}
