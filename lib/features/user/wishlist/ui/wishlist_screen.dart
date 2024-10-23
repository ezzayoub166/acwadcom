// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/explore/data/store_model.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_list_featured_stores.dart';
import 'package:acwadcom/features/user/home/ui/home_screen.dart';
import 'package:acwadcom/features/user/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:acwadcom/features/user/wishlist/widgets/empty_wish_list.dart';
import 'package:acwadcom/features/user/wishlist/widgets/tab_Item.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/user_model.dart';

import '../../home/ui/widgets/build_list_coupons.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  //** the data for WishList  **/
  final List<UserModel> favStores = [];
  final List<String> favCoupns = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedInUser) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: TSizes.defaultSpace,
            vertical: isLoggedInUser ? TSizes.defaultSpace : 5,
          ),
          child: ListView(
            children: [
              isLoggedInUser
                  ? customAppBar(context)
                  : SizedBox(
                      height: 1,
                    ),
              buildSpacerH(10.0),
              ASearchContainer(
                text: AText.search.tr(context),
                onPressed: () => navigateNamedTo(context, Routes.searchScreen),
              ),
              buildSpacerH(20.0),
              Container(
                height: 45.h,
                // margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the entire tab bar
                  // borderRadius: BorderRadius.circular(
                  //   25.0,
                  // ),
                ),
                child: BlocBuilder<WishlistCubit, WishlistState>(
                  builder: (context, state) {
                    // state.maybeWhen(wishlistLoaded: (coupons) => , initial: () {  }, orElse: () {  },);
                    return TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: Color(0xffF1F1F1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      labelColor: ManagerColors.kCustomColor,
                      unselectedLabelColor: ManagerColors.kCustomColor,
                      tabs: [
                        TabItem(title: AText.coupons.tr(context), count: 1),
                        TabItem(title: AText.stores.tr(context), count: 4)
                      ],
                    );
                  },
                ),
              ),
              buildSpacerH(20.0),
              SizedBox(
                height: 400.h,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    CouponsFavoritesScreen(),
                    favStores.isEmpty
                        ? emptyWishList(context)
                        : BuildListFeaturedStores(stores: favStores)
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(
          child: Container(
              padding: EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                // Icon at the top
                SizedBox(
                  width: 100,
                  height: 100,
                  child: svgImage("icBuildLogo", fit: BoxFit.fill),
                ),
                SizedBox(height: 16),

                // Confirmation Text
                Column(children: [
                  myText(
                    "You need to log in to continue.".tr(context),
                    textAlign: TextAlign.center,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ])
              ])));
    }
  }
}

class CouponsFavoritesScreen extends StatefulWidget {
  const CouponsFavoritesScreen({super.key});

  @override
  State<CouponsFavoritesScreen> createState() => _CouponsFavoritesScreenState();
}

class _CouponsFavoritesScreenState extends State<CouponsFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      buildWhen: (previous, current) =>
          current is WishlistLoading ||
          current is WishlistLoaded ||
          current is WishlistFaluire,
      builder: (context, state) {
        return state.maybeWhen(
          wishlistLoading: () => BuildCustomLoader(),
          wishlistLoaded: (coupons) => BuildListCoupons(coupons: coupons),
          emptyWishList: () => emptyWishList(context),
          orElse: () => emptyWishList(context),
        );
      },
    );
  }
}
