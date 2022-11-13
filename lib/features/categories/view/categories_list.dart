part of 'categories_page.dart';

class _CategoriesList extends StatelessWidget {
  const _CategoriesList({Key? key, required this.categories}) : super(key: key);
  final List<JokeCategory> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.2),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: List.generate(
          categories.length,
          (index) => _CategoryButton(category: categories[index]),
        ),
      ),
    );
  }
}
