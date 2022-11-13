part of 'internet_detector_provider.dart';

class NetworkDetectorNotifier extends StateNotifier<AsyncValue<bool>> {
  NetworkDetectorNotifier() : super(const AsyncLoading()) {
    InternetConnectionChecker().onStatusChange.listen((status) {
      late final bool newState;
      switch (status) {
        case InternetConnectionStatus.connected:
          newState = true;
          break;
        case InternetConnectionStatus.disconnected:
          newState = false;
          break;
      }
      if (newState != state.value) {
        state = AsyncData(newState);
      }
    });
  }
}
