import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_categories_grid.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_shimmer_categories_grid.dart';
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
            loadingCatgories: () =>  ShimmerCategoriesGrid(),
            orElse: () {
              return ShimmerCategoriesGrid();
            },
          );
        },
      ),
    );
  }
}
