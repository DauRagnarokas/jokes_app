import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/widgets/error_handler.dart';
import '../../../utils/page_route_no_animation.dart';
import '../../../core/widgets/loader.dart';
import '../../joke_single/view/joke_single_screen.dart';
import '../logic/random_joke_state_provider.dart';
import '../logic/random_joke_states.dart';

class RandomJokeButton extends ConsumerWidget {
  const RandomJokeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<RandomJokeState>(
      randomJokeStateProvider,
      (_, state) => state.whenOrNull(
        error: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              getErrorMessage(error),
            ),
          ),
        ),
      ),
    );
    return ref.watch(randomJokeStateProvider).when(
          initial: () => const _RandomJokeButtonView(),
          data: (data) {
            return const _RandomJokeButtonView();
          },
          error: (Object error, StackTrace stackTrace) =>
              ErrorHandler(error, stackTrace, showMessage: false),
          loading: () => const _RandomJokeButtonView(isLoading: true),
        );
  }
}

///////////////////////////////////////////////////////////////////////////////

class _RandomJokeButtonView extends HookConsumerWidget {
  const _RandomJokeButtonView({Key? key, this.isLoading = false})
      : super(key: key);
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: isLoading
          ? null
          : () => ref.read(randomJokeStateProvider.notifier).request(
                callback: (data) => Navigator.push(
                  context,
                  PageRouteNoAnimation(
                    builder: (context) => JokeSingleScreen(
                      joke: data,
                      title: 'Random Joke',
                    ),
                  ),
                ),
              ),
      child: isLoading
          ? const Loader(
              size: 16,
              strokeWidth: 3,
              color: Colors.black,
            )
          : Visibility(
              child: SizedBox.square(
                dimension: 40,
                child: SvgPicture.asset(
                  'assets/images/norris_head.svg',
                ),
              ),
            ),
    );
  }
}
