import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/widgets/error_handler.dart';
import '../../../utils/page_route_no_animation.dart';
import '../../../core/widgets/loader.dart';
import '../../joke_single/view/joke_single_screen.dart';
import '../logic/random_joke_state_provider.dart';

class RandomJokeButton extends HookConsumerWidget {
  const RandomJokeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isShowing = useState(true);
    return ref.watch(randomJokeStateProvider).when(
          () => _RandomJokeButtonView(isShowing: isShowing.value),
          data: (data) {
            Future.delayed(
                const Duration(seconds: 1), () => isShowing.value = true);
            return _RandomJokeButtonView(
                isLoading: false, isShowing: isShowing.value);
          },
          error: (Object error, StackTrace stackTrace) => ErrorHandler(error, stackTrace),
          loading: () {
            isShowing.value = false;
            return _RandomJokeButtonView(
                isLoading: true, isShowing: isShowing.value);
          },
        );
  }
}

///////////////////////////////////////////////////////////////////////////////

class _RandomJokeButtonView extends HookConsumerWidget {
  const _RandomJokeButtonView(
      {Key? key, this.isLoading = false, required this.isShowing})
      : super(key: key);
  final bool isLoading;
  final bool isShowing;

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
              visible: isShowing,
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
