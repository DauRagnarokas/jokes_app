import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../models/joke.dart';
import '../logic/favourites_providers.dart';
import 'joke_card.dart';

class FavouritesScreen extends HookConsumerWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listKey = useMemoized(() => GlobalKey<AnimatedListState>());
    final List<Joke> items = ref.watch(getFavouriteJokesProvider).reversed.toList();
    if (items.isEmpty) {
      return const _EmptyFavouritesWidget();
    }
    ref.listen(getFavouriteJokesProvider, (previous, next) {
      if ((previous?.length ?? 0) < next.length) {
        listKey.currentState?.insertItem(0);
      }
    });
    return AnimatedList(
      key: listKey,
      padding: const EdgeInsets.symmetric(vertical: 16),
      initialItemCount: items.length,
      itemBuilder: (context, index, animation) => JokeCard(
        key: Key('JokeCard-${items[index].id}'),
        joke: items[index],
        callback: (bool isFavourite) {
          if (!isFavourite) {
            listKey.currentState?.removeItem(
              index,
              (context, animation) => JokeCard(
                key: Key('JokeCard-${items[index].id}'),
                animation: animation,
                joke: items[index].copyWith(isFavourite: isFavourite),
              ),
            );
          }
        },
      ),
    );
  }
}

class _EmptyFavouritesWidget extends StatelessWidget {
  const _EmptyFavouritesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/empty_placeholder.svg',
          ),
          const SizedBox(height: 24),
          Text(
            'You have no favourites',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
