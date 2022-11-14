import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jokes_app/utils/page_route_no_animation.dart';
import '../../../core/widgets/error_handler.dart';
import '../../../models/joke.dart';
import '../../../utils/debouncer.dart';
import '../../../core/widgets/loader.dart';
import '../../joke_single/view/joke_single_screen.dart';
import '../../jokes/logic/jokes_providers.dart';
import '../logic/search_providers.dart';

part 'search_field.dart';

part 'search_results.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          titleSpacing: 0,
          shadowColor: Colors.transparent,
          pinned: true,
          toolbarHeight: 70,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _SearchField(onSearch: (String value) {
              ref.read(searchQueryProvider.notifier).state = value;
              ref.read(searchJokesProvider(value));
            }, onUnfocus: () {
              ref.read(searchQueryProvider.notifier).state = null;
            }),
          ),
        ),
        searchQuery != null
            ? const SearchResults()
            : const _PlaceholderSearchResultsSliver(),
      ],
    );
  }
}

class _PlaceholderSearchResultsSliver extends StatelessWidget {
  const _PlaceholderSearchResultsSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Opacity(
          opacity: 0.6,
          child: Transform.translate(
            offset: const Offset(0, -32),
            child: SvgPicture.asset(
              'assets/images/chuck_norris_approved.svg',
              // color: Colors.brown,
            ),
          ),
        ),
      ),
    );
  }
}
