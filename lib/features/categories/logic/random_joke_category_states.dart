import 'package:freezed_annotation/freezed_annotation.dart';
part 'random_joke_category_states.freezed.dart';

@freezed
abstract class RandomJokeCategoryState<T> with _$RandomJokeCategoryState<T> {
  const factory RandomJokeCategoryState() = _Initial;
  const factory RandomJokeCategoryState.data(T data) = _Data;
  const factory RandomJokeCategoryState.error(String message, StackTrace stack) = _Error;
  const factory RandomJokeCategoryState.loading() = _Loading;
}
