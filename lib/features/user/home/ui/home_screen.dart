// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_empty_list.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_list_categories_shimer.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_list_coupons.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_scroll_offer.dart';
import 'package:acwadcom/features/user/home/ui/widgets/home_categories.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/shimmer/shimmer_effect.dart';
import 'package:acwadcom/helpers/shimmer/shimmer_loading.dart';
import 'package:acwadcom/models/offer_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 

  Widget buildOffersWgt(List<OfferModel> offers) {
    return
         AutoScrollPageView(
          offers: offers,
        );
  }

  // Widget buildCategories() {
  //   return buildCategories(context: context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: customAppBar(context),
        body: BlocProvider(
          create: (context) => getIt<HomeCubit>()
            ..emitGetCategories()
            ..emitGetDiscoverCoupons()
            ..emitGetOffers(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
                vertical: isLoggedInUser ? TSizes.defaultSpace : 5),
            child: ListView(
                shrinkWrap: true, // Adjusts to content size
                children: [
                  isLoggedInUser
                      ? customAppBar(context)
                      : SizedBox(
                          height: 1,
                        ),
                  buildSpacerH(TSizes.spaceBtwItems),
                  ASearchContainer(
                    text: AText.search.tr(context),
                    onPressed: () =>
                        navigateNamedTo(context, Routes.searchScreen),
                  ),
                  buildSpacerH(TSizes.spaceBtwItems),
                  blocBuilderOffers(),
                  buildSpacerH(TSizes.spaceBtwItems),
                  BlocBuilderCategories(),
                  buildSpacerH(TSizes.spaceBtwItems),
                  blocBuilderCoupons(context)
                ]),
          ),
        ));
  }

  ///MARK: Discover Coupons

  Widget blocBuilderCoupons(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        TSectionHeader(
          title: AText.discoverOffers.tr(context),
          textColor: ManagerColors.textColor,
          showActionButton: true,
          onPressed: () => navigateNamedTo(context, Routes.listOfCoupons),
        ),
        buildSpacerH(TSizes.spaceBtwItems),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              current is SuccessFeatchedCoupons ||
              current is LoadingCoupons ||
              current is EmptyCoupons,
          builder: (context, state) {
            return state.maybeWhen(
                loadingCoupons: () => SizedBox(
                    width: double.infinity, child: CouponShimerLoader()),
                successFeatchedCoupons: (coupons) =>
                    BuildListCoupons(coupons: coupons),
                errorFeatchedCoupons: (error) => Container(
                      color: Colors.red,
                      child: Text(error.toString()),
                    ),
                emptyCoupons: () {
                  return buildEmptyListCoupons(
                    screenWidth,
                    screenHeight,
                    context,
                    "There are no coupons for this Category".tr(context),
                  );
                },
                orElse: () {
                  return SizedBox(
                      width: double.infinity, child: CouponShimerLoader());
                });
          },
        )
      ],
    );
  }

  //Offers

  Widget blocBuilderOffers() {
    return BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is LoadingGetOffers ||
            current is FaluireGetOffers ||
            current is SuccessGetOffers ||
            current is EmptyOffers,
        builder: (context, state) {
          return state.maybeWhen(
              loadingGetOffers: () => OfferShimmerItenEffect(),
              successGetOffers: (offers) => buildOffersWgt(offers),
              faluireGetOffers: (error) {
                if (mounted) {
                  TLoader.showErrorSnackBar(context, title: error);
                }
                return SizedBox();
              },
              orElse: () {
                return SizedBox(height: 0);
              });
        });
  }
}

// class CategoriesSection extends StatefulWidget {
//   @override
//   _CategoriesSectionState createState() => _CategoriesSectionState();
// }

// class _CategoriesSectionState extends State<CategoriesSection>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Column(
//       children: [
//         TSectionHeader(
//           title: AText.categorieslbl.tr(context),
//           textColor: ManagerColors.textColor,
//         ),
//         buildSpacerH(TSizes.spaceBtwItems),
//         BlocBuilder<HomeCubit, HomeState>(
//           buildWhen: (previous, current) =>
//               current is LoadingCatgories ||
//               current is SuccessFeatchedCatgories ||
//               current is ErrorFeatchedCatgories,
//           builder: (context, state) {
//             return state.maybeWhen(
//                 loadingCatgories: () => ListShimmerCategoires(),
//                 successFeatchedCatgories: (categories) => ACWHomeCategoires(
//                       arrayOfCategories: categories,
//                     ),
//                 errorFeatchedCatgories: (error) => ListShimmerCategoires(),
//                 orElse: () {
//                   return ListShimmerCategoires();
//                 });
//           },
//         )
//       ],
//     );
//   }
// }

//Categories

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
