// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_offer_item.dart';
import 'package:acwadcom/features/ownerStore/features/home/logic/home_owner/home_owner_state.dart';
import 'package:acwadcom/features/ownerStore/features/home/no_coupon_screen.dart';
import 'package:acwadcom/features/user/explore/logic/cubit/explore_cubit.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_list_categories_shimer.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_list_coupons.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_scroll_offer.dart';
import 'package:acwadcom/features/user/home/ui/widgets/home_categories.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/shimmer/shimmer_effect.dart';
import 'package:acwadcom/helpers/shimmer/shimmer_loading.dart';
import 'package:acwadcom/models/offer_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();
    int currentPageIndex = 0;

    void updatePageIndicator(int index) {
      setState(() {
        currentPageIndex = index;
      });
    }

    Widget buildSmoothIndicator(int countOffers) {
      return Align(
        alignment: Alignment.center,
        child: SmoothPageIndicator(
          controller: pageController,
          onDotClicked: (index) {},
          count: countOffers,
          effect: ExpandingDotsEffect(
            dotWidth: 10.w,
            activeDotColor: ManagerColors.yellowColor,
            dotHeight: 6.h,
          ),
        ),
      );
    }

    Widget buildOffersWgt(List<OfferModel> offers) {
      return SizedBox(
        height: 150,
        
        width: double.infinity,
        child: AutoScrollPageView(offers: offers,)
      );
    }

    Widget buildCategories() {
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
                current is ErrorFeatchedCatgories,
            builder: (context, state) {
              return state.maybeWhen(
                  loadingCatgories: () => ListShimmerCategoires(),
                  successFeatchedCatgories: (categories) => ACWHomeCategoires(
                        arrayOfCategories: categories,
                      ),
                  errorFeatchedCatgories: (error) => ListShimmerCategoires(),
                  orElse: () {
                    return ListShimmerCategoires();
                  });
            },
          )
        ],
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
                    onPressed: () =>  navigateNamedTo(context,Routes.searchScreen),
                  ),
                  buildSpacerH(TSizes.spaceBtwItems),
                  blocBuilderOffers(),
                  buildSpacerH(TSizes.spaceBtwItems),
                  buildCategories(),
                  buildSpacerH(TSizes.spaceBtwItems),
                  blocBuilderCoupons(context)
                ]),
          ),
        ));
  }

  ///MARK: Discover Coupons 

  Widget blocBuilderCoupons(BuildContext context) {
            final screenWidth = MediaQuery.of(context).size.width;

    return Column(
                  children: [
                    TSectionHeader(
                      title: AText.discoverOffers.tr(context),
                      textColor: ManagerColors.textColor,
                      showActionButton: true,
                      onPressed: ()=> navigateNamedTo(context,Routes.listOfCoupons),
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
                                width: double.infinity,
                                child: CouponShimerLoader()),
                            successFeatchedCoupons: (coupons) =>
                                BuildListCoupons(coupons: coupons),
                            errorFeatchedCoupons: (error) => Container(
                                  color: Colors.red,
                                  child: Text(error.toString()),
                                  
                                ),
                                emptyCoupons: () {
                                  return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container for the icon image on top
              SizedBox(
                height: screenWidth * 0.5, // Responsive sizing
                width: screenWidth * 0.5,
                // decoration: BoxDecoration(
                //   color: Colors.orangeAccent,
                //   borderRadius: BorderRadius.circular(12),
                // ),
                child: svgImage(
                  "_icEmpty",
                  size: screenWidth * 0.5,
                  height: screenWidth * 0.5, // Responsive sizing
                ),
              ),
              const SizedBox(height: 24),
              // Main title text
              Text(
                "There are no coupons for this Category".tr(context),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              )
            ]);

                                } ,
                            orElse: () {
                              return SizedBox(
                                width: double.infinity,
                                child: CouponShimerLoader());
                            });
                      },
                    )
                  ],
                );
  }

  //Offers 

  Widget blocBuilderOffers() {
    return BlocBuilder<HomeCubit,HomeState>(
                  buildWhen: (previous, current) => current is LoadingGetOffers || current is FaluireGetOffers || current is SuccessGetOffers || current is EmptyOffers,
                  builder: (context,state){
                    return state.maybeWhen(
                      loadingGetOffers: () => OfferShimmerItenEffect(),
                      successGetOffers: (offers) => Column(
                        children: [
                          buildOffersWgt(offers),
                          buildSpacerH(TSizes.spaceBtwItems),
                          buildSmoothIndicator(offers.length),
                        ],
                      ),
                      faluireGetOffers: (error) {
                        if(mounted){
                           TLoader.showErrorSnackBar(context, title: error);
                        }
                        return SizedBox();
                      } ,
                      orElse: (){
                         return SizedBox(height: 0);
                    });

                });
  }
}


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
              current is LoadingCatgories         ||
              current is SuccessFeatchedCatgories ||
              current is ErrorFeatchedCatgories   ||
              current is CategorySelected,
          builder: (context, state) {
            return state.maybeWhen(
                loadingCatgories: () =>  Center(child: BuildCustomLoader(),),
                successFeatchedCatgories: (categories) =>
                    ACWHomeCategoires(
                      arrayOfCategories: context.read<HomeCubit>().featchedCategories,
                    ),
                errorFeatchedCatgories: (error) =>
                    ListShimmerCategoires(),
                loadingCoupons: () =>
                    Center(child: BuildCustomLoader()),
                successFeatchedCoupons: (coupons) =>
                    BuildListCoupons(coupons: coupons),
                    categorySelected: (index, listofCategories ,listofCoupns) =>  ACWHomeCategoires(
                      arrayOfCategories: listofCategories
                    ),
    
                orElse: () {
                  return ListShimmerCategoires();
                });
          },
        )
      ],
    );
  }
}

