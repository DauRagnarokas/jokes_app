import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jokes_app/services/dio_service.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void main() {
  group('Joke categories -', () {
    test('getJokeCategories - return List<JokeCategory> with given JSON data', () async {
      // ARRANGE
      final jsonResponse = {'name': 'animal'};

      final mockDio = MockDio();
      final mockResponse = MockDioResponse();

      when(() => mockResponse.data).thenReturn([jsonResponse]);
      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

      final container = ProviderContainer(
        overrides: [
          dioClientProvider.overrideWithValue(mockDio),
        ],
      );

      // ACT
      final result = await container.read(dioClientProvider).get('categories');

      // ASSERT
      expect(
        result.data,
        isA<List>()
            .having((list) => list.first['name'], 'first category name', 'animal'),
      );

      verify(() => mockDio.get('categories')).called(1);
    });
  });
}
