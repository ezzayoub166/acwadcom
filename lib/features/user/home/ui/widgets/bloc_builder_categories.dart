import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_list_categories_shimer.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_list_coupons.dart';
import 'package:acwadcom/features/user/home/ui/widgets/home_categories.dart';

class BlocBuilderCategories extends StatelessWidget {
  const BlocBuilderCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TSectionHeader(
          title: AText.categorieslbl.tr(context),
          textColor: ManagerColors.textColor,
          showActionButton: true,
          onPressed: () {
            navigateNamedTo(context, Routes.categoriesScreen);
          },
        ),
        buildSpacerH(TSizes.spaceBtwItems),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              current is LoadingCatgories ||
              current is SuccessFeatchedCatgories ||
              current is ErrorFeatchedCatgories ||
              current is CategorySelected,
          builder: (context, state) {
            return state.maybeWhen(
                loadingCatgories: () => Center(
                      child: BuildCustomLoader(),
                    ),
                successFeatchedCatgories: (categories) => ACWHomeCategoires(
                      arrayOfCategories:
                          context.read<HomeCubit>().featchedCategories,
                    ),
                errorFeatchedCatgories: (error) => ListShimmerCategoires(),
                loadingCoupons: () => Center(child: BuildCustomLoader()),
                successFeatchedCoupons: (coupons) =>
                    BuildListCoupons(coupons: coupons),
                categorySelected: (index, listofCategories, listofCoupns) =>
                    ACWHomeCategoires(arrayOfCategories: listofCategories),
                orElse: () {
                  return ListShimmerCategoires();
                });
          },
        )
      ],
    );
  }
}