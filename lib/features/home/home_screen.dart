import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../widgets/main_scaffold.dart';
import '../navbar/logic/navbar_providers.dart';
import '../../models/nav_page.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int pageIndex = ref.watch(navbarIndexProvider);
    final List<NavPage> pages = ref.watch(navPagesProvider);
    return MainScaffold(
      title: pages[pageIndex].title,
      body: pages[pageIndex].body,
      showFAB: true,
      showNavbar: true,
    );
  }
}
