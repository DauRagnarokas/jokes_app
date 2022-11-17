import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../models/nav_page.dart';
import '../logic/navbar_providers.dart';

Color _selectedColor = Colors.black;

class Navbar extends ConsumerWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<NavPage> pages = ref.watch(navPagesProvider);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: _selectedColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: ref.watch(navbarIndexProvider),
      onTap: (index) {
        ref.read(navbarIndexProvider.notifier).state = index;
      },
      items: List.generate(
        pages.length,
        (index) => BottomNavigationBarItem(
          icon: pages[index].navIcon,
          label: pages[index].navLabel,
        ),
      ),
    );
  }
}
