part of 'search_page.dart';

class SearchResults extends ConsumerWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? searchQuery = ref.watch(searchQueryProvider);
    return ref.watch(searchJokesProvider(searchQuery)).when(
        data: (List<Joke> data) => _SearchResultsList(items: data),
        error: (Object error, StackTrace stackTrace) => ErrorHandler(
              error,
              stackTrace,
              isSliver: true,
            ),
        loading: () => const SliverFillRemaining(child: Loader()));
  }
}

///////////////////////////////////////////////////////////////////////////////

class _SearchResultsList extends StatelessWidget {
  const _SearchResultsList({Key? key, required this.items}) : super(key: key);
  final List<Joke> items;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) => _buildTile(items[index], context),
        childCount: items.length,
      ),
    );
  }

  Widget _buildTile(Joke joke, BuildContext context) {
    return Card(
      child: InkWell(
        key: Key('SearchJokeCard-${joke.id}'),
        onTap: () => Navigator.push(
          context,
          PageRouteNoAnimation(
            builder: (context) => JokeSingleScreen(joke: joke, title: 'Single Joke',),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Text(
            joke.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
      ),
    );
  }
}
