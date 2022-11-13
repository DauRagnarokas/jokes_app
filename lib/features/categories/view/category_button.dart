part of 'categories_page.dart';

class _CategoryButton extends HookConsumerWidget {
  const _CategoryButton({Key? key, required this.category}) : super(key: key);
  final JokeCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isShowing = useState(true);
    return ref.watch(randomJokeCategoryStateProvider(category)).when(
          () => _CategoryButtonView(
            isShowing: isShowing.value,
            category: category,
          ),
          data: (data) {
            Future.delayed(
                const Duration(seconds: 1), () => isShowing.value = true);
            return _CategoryButtonView(
              isLoading: false,
              isShowing: isShowing.value,
              category: category,
            );
          },
          error: (Object error, StackTrace stackTrace) => ErrorHandler(error, stackTrace),
          loading: () {
            isShowing.value = false;
            return _CategoryButtonView(
              isLoading: true,
              isShowing: isShowing.value,
              category: category,
            );
          },
        );
  }
}

///////////////////////////////////////////////////////////////////////////////

class _CategoryButtonView extends HookConsumerWidget {
  const _CategoryButtonView(
      {Key? key,
      required this.category,
      this.isLoading = false,
      required this.isShowing})
      : super(key: key);
  final bool isLoading;
  final bool isShowing;
  final JokeCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            Opacity(
                opacity: isShowing ? 1 : 0,
                child: Transform.rotate(
                  angle: (Random().nextDouble() * 0.1) - 0.05,
                  child: Text(
                    category.name.toUpperCase(),
                    style: const TextStyle(fontSize: 18, letterSpacing: 1),
                  ),
                )),
            const SizedBox.square(
              dimension: 12,
              child: Loader(strokeWidth: 2, color: Colors.black,),
            ),
          ],
        ),
      ),
    );
  }
}
