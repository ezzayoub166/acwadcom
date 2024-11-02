import 'dart:async';
import 'package:acwadcom/features/admin/ui/widgets/build_offer_item.dart';
import 'package:acwadcom/models/offer_model.dart';
import 'package:flutter/material.dart';

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
    return PageView.builder(
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
    );
  }
}
