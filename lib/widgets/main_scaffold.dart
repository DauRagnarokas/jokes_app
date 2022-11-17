import 'package:flutter/material.dart';
import 'package:jokes_app/constants.dart';

import '../../features/navbar/view/navbar.dart';
import '../../features/random_joke_button/view/random_joke_button.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({Key? key, required this.title, required this.body, this.showFAB = false, this.showNavbar = false})
      : super(key: key);
  final String title;
  final Widget body;
  final bool showFAB;
  final bool showNavbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(paddingBody),
        child: body,
      ),
      bottomNavigationBar: showNavbar ? const Navbar() : null,
      floatingActionButton: showFAB ? const RandomJokeButton() : null,
    );
  }
}
