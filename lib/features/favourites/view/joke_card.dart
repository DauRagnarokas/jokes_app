import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

import '../../../models/joke.dart';
import '../../../widgets/bounce_animation_widget.dart';
import '../logic/favourites_providers.dart';

class JokeCardAnimated extends HookConsumerWidget {
  const JokeCardAnimated(
      {Key? key,
      required this.joke,
      this.callback,
      this.before,
      this.animation})
      : super(key: key);
  final Joke joke;
  final FutureOr Function(bool)? before;
  final Function(bool)? callback;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context, WidgetRef ref) => BounceAnimationWidget(
        child: JokeCard(
          joke: joke,
          before: before,
          callback: callback,
          animation: animation,
        ),
      );
}

class JokeCard extends HookConsumerWidget {
  const JokeCard(
      {Key? key,
      required this.joke,
      this.callback,
      this.before,
      this.animation})
      : super(key: key);
  final Joke joke;
  final FutureOr Function(bool)? before;
  final Function(bool)? callback;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isFavourite = useState(_isFavouriteJoke(ref));
    final Widget buildBody = _buildBody(
      context: context,
      ref: ref,
      isFavourite: isFavourite,
    );
    return animation != null
        ? SizeTransition(
            sizeFactor: animation!,
            child: buildBody,
          )
        : buildBody;
  }

  Widget _buildBody(
      {required BuildContext context,
      required WidgetRef ref,
      required ValueNotifier<bool> isFavourite}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
                child: Text(joke.value),
              )),
              const VerticalDivider(
                color: Colors.grey,
              ),
              Transform.translate(
                offset: const Offset(-4, 0),
                child: IconButton(
                  onPressed: isFavourite.value
                      ? () async {
                          isFavourite.value = !isFavourite.value;
                          await before?.call(isFavourite.value);
                          ref.read(deleteFavouriteJokeProvider(joke));
                          ref.invalidate(getFavouriteJokesProvider);
                          callback?.call(isFavourite.value);
                        }
                      : () async {
                          isFavourite.value = true;
                          await before?.call(isFavourite.value);
                          ref.read(addFavouriteJokeProvider(joke));
                          ref.invalidate(getFavouriteJokesProvider);
                          callback?.call(isFavourite.value);
                        },
                  icon: Icon(
                    Icons.star,
                    color:
                        isFavourite.value ? Colors.amber : Colors.grey.shade400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isFavouriteJoke(WidgetRef ref) {
    final List<Joke> favouriteJokes = ref.watch(getFavouriteJokesProvider);
    final result = favouriteJokes.firstWhereOrNull(
      (element) => element.id == joke.id,
    );
    return result != null;
  }
}
