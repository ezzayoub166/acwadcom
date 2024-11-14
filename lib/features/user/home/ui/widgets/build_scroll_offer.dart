import 'dart:async';
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_offer_item.dart';
import 'package:acwadcom/models/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AutoScrollPageView extends StatefulWidget {
  final List<OfferModel> offers; // Replace with your actual data type

  const AutoScrollPageView({super.key, required this.offers});

  @override
  _AutoScrollPageViewState createState() => _AutoScrollPageViewState();
}

class _AutoScrollPageViewState extends State<AutoScrollPageView> {
  late PageController pageController;
  late Timer autoScrollTimer;
  int currentPage = 0;



  void updatePageIndicator(int index) {
    setState(() {
      currentPage = index;
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

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);

    // Start the timer to auto-scroll the pages
    autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage < widget.offers.length - 1) {
        currentPage++;
      } else {
        currentPage = 0; // Reset to the first page when reaching the end
      }
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    // Dispose of the PageController and cancel the Timer
    pageController.dispose();
    autoScrollTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
        height: 150,
        width: double.infinity,
          child: PageView.builder(
            itemCount: widget.offers.length,
            allowImplicitScrolling: true,
            reverse: true,
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return BuildOfferItem(offer: widget.offers[index]);
            },
          ),
        ),
        buildSpacerH(10.0),
        buildSmoothIndicator(widget.offers.length)
      ],
    );
  }
}
