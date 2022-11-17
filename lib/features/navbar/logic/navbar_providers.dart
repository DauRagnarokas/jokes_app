import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../models/nav_page.dart';
import '../../categories/view/categories_page.dart';
import '../../favourites/view/favourites_page.dart';
import '../../search/view/search_page.dart';
final navbarIndexProvider = StateProvider<int>((_) => 0);

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
