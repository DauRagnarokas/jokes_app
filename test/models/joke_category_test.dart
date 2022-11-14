import 'package:flutter_test/flutter_test.dart';
import 'package:jokes_app/models/joke_category.dart';

void main() {
  group('Category:', () {
    test('fromJson', () {
      const jsonResponse = 'Celebrity';

      final category = JokeCategory.fromJson(jsonResponse);

      expect(category, isA<JokeCategory>().having((e) => e.name, 'name', 'Celebrity'));
    });
  });
}
