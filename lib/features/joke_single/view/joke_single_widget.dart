import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/widgets/error_handler.dart';
import '../../../core/widgets/loader.dart';
import '../../../models/joke.dart';
import '../../jokes/logic/jokes_providers.dart';

class JokeSingleWidget extends ConsumerWidget {
  const JokeSingleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getRandomJokeProvider).when(
        data: (Joke data) => _buildContent(context, data),
        error: (Object error, StackTrace stackTrace) => ErrorHandler(error, stackTrace),
        loading: () => const Loader());
  }

  Widget _buildContent(BuildContext context, Joke data) {
    return Container(
      alignment: const Alignment(0, -0.2),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Text(data.value.toString()),
        ),
      ),
    );
  }
}
