import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jokes_app/core/widgets/error_handler.dart';
import 'package:jokes_app/utils/string_extensions.dart';
import '../../../models/joke.dart';
import '../../../models/joke_category.dart';
import '../../../utils/page_route_no_animation.dart';
import '../../joke_single/view/joke_single_screen.dart';
import '../../jokes/logic/jokes_providers.dart';
import '../logic/random_joke_category_providers.dart';
import '../../../core/widgets/loader.dart';
import '../logic/random_joke_category_states.dart';

part 'category_button.dart';

part 'categories_list.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getJokeCategoriesProvider).when(
          data: (List<JokeCategory> data) => _CategoriesList(categories: data),
          error: (Object error, StackTrace stackTrace) =>
              ErrorHandler(error, stackTrace),
          loading: () => const Loader(),
        );
  }
}
