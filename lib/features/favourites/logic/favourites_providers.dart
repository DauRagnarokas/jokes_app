import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/constants.dart';
import '../../../services/hive_service.dart';
import '../../../models/joke.dart';

final initHiveProvider = FutureProvider<void>((_) async {
  await HiveService.init();
  await HiveService.openBox<Joke>(kFavouriteJokes);
});

final favouritesHiveBoxProvider = Provider.autoDispose<Box<Joke>>(
  (_) => HiveService.getBox<Joke>(kFavouriteJokes),
);

final getFavouriteJokesProvider = Provider.autoDispose<List<Joke>>((ref) {
  final box = ref.watch(favouritesHiveBoxProvider);
  final items = List<Joke>.from(box.values);
  return items;
});

final addFavouriteJokeProvider = Provider.autoDispose.family<void, Joke>(
  (ref, joke) {
    final Box<Joke> box = ref.watch(favouritesHiveBoxProvider);
    box.add(joke.copyWith(isFavourite: true));
  },
);

final deleteFavouriteJokeProvider = Provider.autoDispose.family<void, Joke>(
  (ref, joke) {
    final box = ref.watch(favouritesHiveBoxProvider);
    dynamic key;
    for (MapEntry<dynamic, Joke> item in box.toMap().entries) {
      if (item.value.id == joke.id) {
        key = item.key;
        break;
      }
    }
    if (key != null) {
      box.delete(key);
    } else {
      throw 'Could not find joke element in local memory with id: ${joke.id}';
    }
  },
);
