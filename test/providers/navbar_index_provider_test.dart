import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jokes_app/features/navbar/logic/navbar_providers.dart';

void main() {
  group('NavBar Index Provider:', () {
    test('change index', () {

      final container = ProviderContainer();

      // ASSERT
      expect(container.read(navbarIndexProvider), 0);

      // ACT
      container.read(navbarIndexProvider.notifier).state = 1;
      // ASSERT
      expect(container.read(navbarIndexProvider), 1);

      // ACT
      container.read(navbarIndexProvider.notifier).state = 2;
      // ASSERT
      expect(container.read(navbarIndexProvider), 2);

      // ACT
      container.read(navbarIndexProvider.notifier).state = 1;
      // ASSERT
      expect(container.read(navbarIndexProvider), 1);
    });

    test('clear value', () {
      final container = ProviderContainer();
      final provider = container.read(navbarIndexProvider);

      // ASSERT
      expect(provider, 0);
    });
  });
}
