part of 'search_page.dart';

class _SearchField extends HookConsumerWidget {
  const _SearchField({Key? key, required this.onSearch, this.onUnfocus})
      : super(key: key);
  final Function(String) onSearch;
  final Function? onUnfocus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Debouncer debouncer = useMemoized(() => Debouncer());
    final TextEditingController searchController =
        useTextEditingController(text: '');
    final FocusNode searchFocusNode = useFocusNode();
    useEffect(() {
      searchController.addListener(() {
        if (searchController.text.isNotEmpty) {
          debouncer.run(() {
            onSearch(searchController.text);
          });
        }
      });
      return null;
    }, []);
    return TextField(
      style: const TextStyle(fontSize: 18),
      textInputAction: TextInputAction.search,
      controller: searchController,
      focusNode: searchFocusNode,
      decoration: InputDecoration(
        prefixIcon: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        suffixIcon: Visibility(
          visible: searchController.text.isNotEmpty,
          child: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                searchFocusNode.unfocus();
                onUnfocus?.call();
              }),
        ),
        hintText: 'Search..',
      ),
    );
  }
}
