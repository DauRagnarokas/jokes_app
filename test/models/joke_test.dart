import 'package:flutter_test/flutter_test.dart';
import 'package:jokes_app/models/joke.dart';

void main() {
  group(
    'Joke:',
    () {
      const id = '123456789';
      var value = 'Woodchuck of a lively courage, pull the endurance!';
      Map<String, dynamic> json = {
        'id': id,
        'value': value,
        'isFavourite': false
      };
      test(
        'fromJson',
        () {
          final category = Joke.fromJson(json);

          expect(category, isA<Joke>().having((e) => e.id, 'id', id));
        },
      );
      test(
        'copyWith',
        () {
          final Joke joke = Joke.fromJson(json);
          final Joke jokeNew = joke.copyWith(isFavourite: true);

          expect(jokeNew, isA<Joke>().having((e) => e.id, 'id', id));
          expect(jokeNew, isA<Joke>().having((e) => e.value, 'value', value));
          expect(jokeNew,
              isA<Joke>().having((e) => e.isFavourite, 'isFavourite', true));
        },
      );
    },
  );
}
