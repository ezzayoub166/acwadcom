// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/app_localizations.dart';
import 'package:acwadcom/common/widgets/build_app_bar.dart';
import 'package:acwadcom/common/widgets/build_spacer_height.dart';
import 'package:acwadcom/features/coupons/ui/screens/coupon_deatls_screen.dart';
import 'package:acwadcom/features/home/ui/widgets/build_featured_code.dart';
import 'package:acwadcom/features/home/ui/widgets/build_filter_bottom_sheet.dart';
import 'package:acwadcom/features/home/ui/widgets/home_categories.dart';
import 'package:acwadcom/features/home/ui/widgets/search_widget.dart';
import 'package:acwadcom/features/home/ui/widgets/section_header.dart';
import 'package:acwadcom/helpers/constants/colors.dart';
import 'package:acwadcom/helpers/constants/sizes.dart';
import 'package:acwadcom/helpers/constants/strings.dart';
import 'package:acwadcom/helpers/util/extenstions.dart';
import 'package:acwadcom/helpers/widgets/common/svgImageWgt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    int currentPageIndex = 0;

    var arrayOfCategories = [
      CategoryModel(title: AText.all.tr(context), image: "_icAll"),
      CategoryModel(title: AText.groceries.tr(context), image: "_icShoppingBasket"),
      CategoryModel(title: AText.resturnts.tr(context), image: "icBell"),
      CategoryModel(title: AText.delivery.tr(context), image: "_icDelivery_svgrepo"),
      CategoryModel(title: AText.fashion.tr(context), image: "_icDress"),
    ];

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
          ACWHomeCategoires(
            arrayOfCategories: arrayOfCategories,
          )
        ],
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: customAppBar(context),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace , vertical: TSizes.defaultSpace),
          child: ListView(
                      shrinkWrap: true, // Adjusts to content size
            children: [
            customAppBar(context),
            buildSpacerH(10.0),
            ASearchContainer(text: AText.search.tr(context),),
            buildSpacerH(5.0),
            buildOffersWgt(),
            buildSpacerH(TSizes.spaceBtwItems),
            buildSmoothIndicator(),
            buildSpacerH(TSizes.spaceBtwItems),
            buildCategories(),
            buildSpacerH(TSizes.spaceBtwItems),
            Column(
              children:  [
                TSectionHeader(title: AText.discoverOffers.tr(context),textColor: ManagerColors.textColor,),
                 buildSpacerH(TSizes.spaceBtwItems),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx , index){
                  return InkWell(
                    onTap: (){
                      navigateTo(context, CouponDeatlsScreen());
                    },
                    child: BuildFeaturedCode());
                }, 
                separatorBuilder: (ctx , index ) => buildSpacerH(10.0), itemCount: 6)
              ],
            )


          ]),
        ));
  }
}
