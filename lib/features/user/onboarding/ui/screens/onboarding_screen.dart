import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/services/cachce_services/chache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:acwadcom/features/user/onboarding/ui/widgets/build_item_onBoarding.dart';

import 'package:acwadcom/helpers/util/device_utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updatePageIndicator(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _navigateToNextPage() {
    if (_currentPageIndex == 2) {
      navigateNamedTo(context, Routes.loginScreen);
      CacheHelper.instance.saveValueWithKey('OpenApp', true);

    } else {
      _pageController.animateToPage(
        _currentPageIndex + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  Widget _buildPageIndicator() {
    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 80.h,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.center,
        child: SmoothPageIndicator(
          controller: _pageController,
          onDotClicked: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          count: 3,
          effect: ExpandingDotsEffect(
            dotWidth: 10.w,
            activeDotColor: ManagerColors.yellowColor,
            dotHeight: 6.h,
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Positioned(
      right: 16.w,
      left: 16.w,
      bottom: TDeviceUtils.getBottomNavigationBarHeight() - 20.h,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: _navigateToNextPage,
          style: ElevatedButton.styleFrom(
            backgroundColor: ManagerColors.yellowColor,
            foregroundColor: Colors.white,
          ),
          child: myText(AText.next.tr(context) , fontSize: 18 , color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildOnboardingPages() {
    final List<Map<String, String>> onboardingData = [
      {
        'title': 'Get special discounts easily',
        'description': 'Register now to be the first to know about the latest offers and coupons, and benefit from saving money easily and conveniently.',
        'image': 'onBoarding_image_one',
      },
      {
        'title': 'Join us and save more',
        'description': 'Use our exclusive coupons to get great discounts. Download the app and enjoy a unique shopping experience with the best offers.',
        'image': 'onBoarding_image_tow',
      },
      {
        'title': 'Discover the world of discounts with one touch',
        'description': 'The easiest and fastest way to request various vehicle cleaning services to cover all your needs anytime and anywhere',
        'image': 'onBoarding_image_three',
      }
    ];

    return PageView.builder(
      controller: _pageController,
      onPageChanged: _updatePageIndicator,
      itemCount: onboardingData.length,
      itemBuilder: (context, index) {
        final data = onboardingData[index];
        return buildItemOnBoarding(
          data['title']!.tr(context),
          data['description']!.tr(context),
          data['image']!,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive scaling
    ScreenUtil.init(context, designSize: const Size(375, 812), minTextAdapt: true);
    return Scaffold(
      backgroundColor: ManagerColors.kCustomColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          _buildOnboardingPages(),
          _buildPageIndicator(),
          _buildNextButton(),
        ],
      ),
    );
  }
}