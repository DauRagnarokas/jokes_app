import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jokes_app/core/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(paddingBody),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                height: 300,
                'assets/images/chuck_norris_approved.svg',
                color: Colors.brown.shade800,
              ),
              const SizedBox(height: 32),
              Text('Jokes App', style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.brown.shade800),),
            ],
          ),
        ),
      ),
    );
  }
}
