import 'package:hooks_riverpod/hooks_riverpod.dart';

final delayProvider = FutureProvider.family<void, Duration>(
  (ref, duration) async => await Future.delayed(duration),
);
