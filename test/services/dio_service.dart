import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jokes_app/constants.dart';
import 'package:jokes_app/services/dio_service.dart';

void main() {
  group('DioService:', () {
    test('Initialized correctly with a correct baseUrl', () {
      // ARRANGE
      final container = ProviderContainer();

      final dio = container.read(dioClientProvider);

      // ASSERT
      expect(dio, isA<Dio>());

      expect(dio.options.baseUrl, baseUrl);
    });
  });
}
