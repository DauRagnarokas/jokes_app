import 'package:freezed_annotation/freezed_annotation.dart';
part 'random_joke_category_states.freezed.dart';

@freezed
abstract class RandomJokeCategoryState<T> with _$RandomJokeCategoryState<T> {
  const factory RandomJokeCategoryState.initial() = _Initial;
  const factory RandomJokeCategoryState.data(T data) = _Data;
  const factory RandomJokeCategoryState.error(Object error, StackTrace stack) = _Error;
  const factory RandomJokeCategoryState.loading() = _Loading;
}
