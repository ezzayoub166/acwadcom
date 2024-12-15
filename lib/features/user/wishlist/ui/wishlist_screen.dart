// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/wishlist/logic/coupons_wishlist/cubit/wihslist_coupons_cubit.dart';
import 'package:acwadcom/features/user/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:acwadcom/features/user/wishlist/ui/stores_favorites_screen.dart';
import 'package:acwadcom/features/user/wishlist/widgets/tab_Item.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/models/user_model.dart';
import 'coupons_favorites_screen.dart';

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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: TSizes.defaultSpace,
              vertical: isLoggedInUser ? TSizes.defaultSpace : 5,
            ),
            child: Column(
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
                  child:  TabBar(
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
          
                         BlocBuilder<WishListCouponsCubit, WishListCouponsState>(
                          buildWhen: (previous, current) => current is GetNumberOFCouponsInWishList,
                        builder: (context, state) {
                          if(state is GetNumberOFCouponsInWishList){
                          return TabItem(title: AText.coupons.tr(context), count:state.count);
                          }
                          return TabItem(title: AText.coupons.tr(context), count:0);
          
                        },
                      ),
                      BlocBuilder<WishlistStoresCubit, WishListStoresState>(
                         buildWhen: (previous, current) => current is GetNumberOFStoresInWishList,
                        builder: (context, state) {
                        
                          if(state is GetNumberOFStoresInWishList){
                          return TabItem(title: AText.stores.tr(context), count: state.count);
                          }
                          return TabItem(title: AText.stores.tr(context), count: 0);
          
          
                        },
                      )
                          
                        ],
                  )
                     
                  ),
                buildSpacerH(20.0),
                SizedBox(
                  height: 400.h,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      
                      CouponsFavoritesScreen(),
                      StoresWishListScreen()
                    ],
                  ),
                ),
              ],
            ),
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




