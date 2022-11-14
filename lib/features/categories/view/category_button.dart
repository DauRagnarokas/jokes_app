part of 'categories_page.dart';

class _CategoryButton extends ConsumerWidget {
  const _CategoryButton({Key? key, required this.category}) : super(key: key);
  final JokeCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(randomJokeCategoryStateProvider(category)).when(
          initial: () => _CategoryButtonView(
            category: category,
          ),
          data: (data) => _CategoryButtonView(
            category: category,
          ),
          error: (Object error, StackTrace stackTrace) =>
              ErrorHandler(error, stackTrace, showMessage: false,),
          loading: () {
            return _CategoryButtonView(
              isLoading: true,
              category: category,
            );
          },
        );
  }
}

///////////////////////////////////////////////////////////////////////////////

class _CategoryButtonView extends HookConsumerWidget {
  const _CategoryButtonView({
    Key? key,
    required this.category,
    this.isLoading = false,
  }) : super(key: key);
  final bool isLoading;
  final JokeCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<RandomJokeCategoryState>(
      randomJokeCategoryStateProvider(category),
      (_, state) => state.whenOrNull(
        error: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              getErrorMessage(error),
            ),
          ),
        ),
      ),
    );
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () => ref
              .read(randomJokeCategoryStateProvider(category).notifier)
              .request(
                callback: (Joke data) => Navigator.push(
                  context,
                  PageRouteNoAnimation(
                    builder: (context) => JokeSingleScreen(
                      joke: data,
                      title: '${category.name.capitalize()} Joke',
                    ),
                  ),
                ),
              ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: IndexedStack(
          alignment: Alignment.center,
          index: isLoading ? 1 : 0,
          children: [
            Transform.rotate(
              angle: (Random().nextDouble() * 0.1) - 0.05,
              child: Text(
                category.name.toUpperCase(),
                style: const TextStyle(fontSize: 18, letterSpacing: 1),
              ),
            ),
            const SizedBox.square(
              dimension: 12,
              child: Loader(
                strokeWidth: 2,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
