import 'package:freezed_annotation/freezed_annotation.dart';
part 'random_joke_states.freezed.dart';

@freezed
abstract class RandomJokeState<T> with _$RandomJokeState<T> {
  const factory RandomJokeState() = _Initial;
  const factory RandomJokeState.data(T data) = _Data;
  const factory RandomJokeState.error(String message, StackTrace stack) = _Error;
  const factory RandomJokeState.loading() = _Loading;
}
