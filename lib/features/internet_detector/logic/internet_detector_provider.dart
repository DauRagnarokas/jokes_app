import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_detector_notifier.dart';


final internetDetectorProvider = StateNotifierProvider.autoDispose<NetworkDetectorNotifier, AsyncValue<bool>>((ref) {
  return NetworkDetectorNotifier();
});
