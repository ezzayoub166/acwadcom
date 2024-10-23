// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/coupons/ui/screens/coupon_deatls_screen.dart';
import 'package:acwadcom/features/user/home/logic/avatar/avatar_cubit.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_featured_code.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_list_categories_shimer.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_list_coupons.dart';
import 'package:acwadcom/features/user/home/ui/widgets/home_categories.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BlocProvider.of<HomeCubit>(context).emitSelectedCategory(0);
  }


  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    int currentPageIndex = 0;

    void updatePageIndicator(int index) {
      setState(() {
        currentPageIndex = index;
      });
    }

    Widget buildSmoothIndicator() {
      return Align(
        alignment: Alignment.center,
        child: SmoothPageIndicator(
          controller: pageController,
          onDotClicked: (index) {},
          count: 3,
          effect: ExpandingDotsEffect(
            dotWidth: 10.w,
            activeDotColor: ManagerColors.yellowColor,
            dotHeight: 6.h,
          ),
        ),
      );
    }

    Widget buildOffersWgt() {
      return SizedBox(
        height: 180,
        width: double.infinity,
        // width: MediaQuery.of(context).size.width,
        child: PageView.builder(
          allowImplicitScrolling: true,
          reverse: true,
          controller: pageController,
          onPageChanged: updatePageIndicator,
          itemBuilder: (context, index) =>
              Padding(padding: EdgeInsets.zero, child: myImage("offer")),
        ),
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

    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: customAppBar(context),
        body: BlocProvider(
          create: (context) => getIt<HomeCubit>()
            ..emitGetCategories()
            ..emitGetCoupons(),
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
                  buildSpacerH(10.0),
                  ASearchContainer(
                    text: AText.search.tr(context),
                    onPressed: () =>  navigateNamedTo(context,Routes.searchScreen),
                  ),
                  buildSpacerH(5.0),
                  buildOffersWgt(),
                  buildSpacerH(TSizes.spaceBtwItems),
                  buildSmoothIndicator(),
                  buildSpacerH(TSizes.spaceBtwItems),
                  Column(
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
                              loadingCatgories: () => ListShimmerCategoires(),
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
                  ),
                  buildSpacerH(TSizes.spaceBtwItems),
                  Column(
                    children: [
                      TSectionHeader(
                        title: AText.discoverOffers.tr(context),
                        textColor: ManagerColors.textColor,
                      ),
                      buildSpacerH(TSizes.spaceBtwItems),
                      BlocBuilder<HomeCubit, HomeState>(
                        buildWhen: (previous, current) =>
                            current is SuccessFeatchedCoupons ||
                            current is LoadingCoupons,
                        builder: (context, state) {
                          return state.maybeWhen(
                              loadingCoupons: () => Center(
                                    child: BuildCustomLoader()
                                  ),
                              successFeatchedCoupons: (coupons) =>
                                  BuildListCoupons(coupons: coupons),
                              errorFeatchedCoupons: (error) => Container(
                                    color: Colors.red,
                                    child: Text(error.toString()),
                                  ),
                              orElse: () {
                                return SizedBox();
                              });
                        },
                      )
                    ],
                  )
                ]),
          ),
        ));
  }
}
