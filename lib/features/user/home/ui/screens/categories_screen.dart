import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_category_item.dart';
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int selectedCategoryIndex = 0; // State to track the selected category index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithBackButton(context, isRTL(context),
          title: AText.categorieslbl.tr(context)),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is LoadingCatgories ||
            current is SuccessFeatchedCatgories,
        builder: (context, state) {
          return state.maybeWhen(
            successFeatchedCatgories: (categories) {
              return CategoriesGrid(
                categories: categories,
                selectedCategoryIndex: selectedCategoryIndex,
                onCategorySelected: (index) {
                  setState(() {
                    selectedCategoryIndex = index; // Update state on click
                  });
                },
              );
            },
            loadingCatgories: () => BuildCustomLoader(),
            orElse: () {
              return BuildCustomLoader();
            },
          );
        },
      ),
    );
  }
}

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
