import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/categories/view/categories_page.dart';
import '../../features/favourites/view/favourites_page.dart';
import '../../features/search/view/search_page.dart';
import '../../models/nav_page.dart';

final delayProvider = FutureProvider.family<void, Duration>((ref, duration) async => await Future.delayed(duration));

final navPagesProvider = Provider<List<NavPage>>(
  (_) => [
    NavPage(
      title: 'Categories',
      navIcon: const Icon(Icons.category),
      navLabel: 'Categories',
      body: const CategoriesPage(),
    ),
    NavPage(
      title: 'Search',
      navIcon: const Icon(Icons.search),
      navLabel: 'Search',
      body: const SearchPage(),
    ),
    NavPage(
      title: 'Favourites',
      navIcon: const Icon(Icons.star),
      navLabel: 'Favourites',
      body: const FavouritesScreen(),
    ),
  ],
);
