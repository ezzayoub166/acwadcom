import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_category_item.dart';

class CategoriesGrid extends StatelessWidget {
  final List<CategoryModel> categories;
  final int selectedCategoryIndex;
  final Function(int index) onCategorySelected;

  const CategoriesGrid({
    super.key,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 items per row
          crossAxisSpacing: 16.0, // Spacing between columns
          mainAxisSpacing: 16.0, // Spacing between rows
        ),
        itemCount: categories.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onCategorySelected(index); // Call the callback to update state
              Future.delayed(Duration(seconds: 1)).then((_) {
                navigateNamedTo(context, Routes.couponsByCategoryIdScreen,
                    categories[index]);
              });
            },
            child: buildCategoryItem(
              context: context,
              category: categories[index],
              selectedIndex: selectedCategoryIndex,
              itemIndex: index,
            ),
          );
        },
      ),
    );
  }
}
