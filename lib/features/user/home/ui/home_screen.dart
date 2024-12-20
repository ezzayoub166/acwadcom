// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_shimmer_list_of_coupons.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/bloc_builder_categories.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_empty_list.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_list_coupons.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_scroll_offer.dart';
import 'package:acwadcom/helpers/shimmer/shimmer_effect.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: customAppBar(context),
        body: BlocProvider(
          create: (context) => getIt<HomeCubit>()
            ..emitGetCategories()
            ..emitGetOffers(),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: TSizes.defaultSpace,
                    vertical: isLoggedInUser ? TSizes.defaultSpace : 5),
                child: Column(
                    // shrinkWrap: true, // Adjusts to content size
                    children: [
                      customAppBar(context),
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
            ),
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
                loadingCoupons: () => buildShimmerListOfCoupons(),
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
                  return buildShimmerListOfCoupons();
                }
                );
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