import 'package:flutter/material.dart';
import '../../../core/widgets/main_scaffold.dart';
import '../../../models/joke.dart';
import '../../favourites/view/joke_card.dart';

class JokeSingleScreen extends StatelessWidget {
  const JokeSingleScreen({Key? key, required this.joke, required this.title})
      : super(key: key);
  final Joke joke;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: title,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      alignment: const Alignment(0, -0.2),
      child: JokeCardAnimated(joke: joke),
    );
  }
}
