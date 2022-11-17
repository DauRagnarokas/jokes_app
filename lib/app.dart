import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jokes_app/features/splash/splash_screen.dart';
import 'package:jokes_app/features/home/home_screen.dart';
import 'package:jokes_app/providers/core_providers.dart';
import 'package:jokes_app/themes/light_theme.dart';
import 'package:jokes_app/widgets/error_handler.dart';
import 'package:jokes_app/widgets/main_scaffold.dart';
import 'features/favourites/logic/favourites_providers.dart';
import 'features/internet_detector/logic/internet_detector_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Jokes',
      debugShowCheckedModeBanner: false,
      theme: LightTheme.data(),
      home: Consumer(builder: (_, WidgetRef ref, __) {
        return ref.watch(internetDetectorProvider).when(
            data: (bool data) => data
                ? _loadLocalMemory(ref)
                :  MainScaffold(
                    title: 'No Internet',
                    body: Center(
                      child: Text('Check your network connection', style: Theme.of(context).textTheme.headline6,),
                    ),
                  ),
            error: (Object error, StackTrace stackTrace) => MainScaffold(
                  title: 'Network Error',
                  body: ErrorHandler(error, stackTrace),
                ),
            loading: () => const SplashScreen());
      }),
    );
  }

  Widget _loadLocalMemory(WidgetRef ref) {
    return ref.watch(initHiveProvider).when(
        data: (data) {
          return _delay(ref);
        },
        error: (Object error, StackTrace stackTrace) => MainScaffold(
              title: 'Memory Error',
              body: ErrorHandler(error, stackTrace),
            ),
        loading: () => const SplashScreen());
  }

  Widget _delay(WidgetRef ref) {
    return ref.watch(delayProvider(const Duration(seconds: 1))).maybeWhen(
          data: (data) => const HomeScreen(),
          orElse: () => const SplashScreen(),
        );
  }
}
