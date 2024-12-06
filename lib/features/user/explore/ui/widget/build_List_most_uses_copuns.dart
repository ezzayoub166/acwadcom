// ignore_for_file: file_names

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_coupon_clipper_widget.dart';
import 'package:acwadcom/features/user/wishlist/data/wihslist_repository.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/coupon_model.dart';

class BuildListMostUserCopuns extends StatelessWidget {
  const BuildListMostUserCopuns({
    super.key,
    required this.itemWidth,
    this.axis = Axis.horizontal,
    this.isExpanded = false,
    required this.coupons,
    
  });

  final double itemWidth;
  final Axis axis;
  final bool isExpanded;
  final List<Coupon> coupons;
  

  Future<bool> checkIfCouponsIsFav(couponID){
   final isFav =  getIt<WihslistRepository>().isWishListCoupon(couponID);
   return isFav;
  }



  



  @override
  Widget build(BuildContext context) {


    
    double totalHeight = coupons.length * 160.h;
    return SizedBox(
      height: totalHeight,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: axis,
        itemCount: coupons.length,
        separatorBuilder: (ctx, index) => buildSpacerH(10.0),
        itemBuilder: (context, index) {
            //  bool isFav =  checkIfCouponsIsFav(coupons[index]);

          return buildCouponClipperItem(context, coupons[index]);
        },
      ),
    );
  }
}


//have the list of ids for coupons in shared prefreces ..
//when user add the item in wishlist 
// 1. save coupon in wishlist in firebase 
// 2. save coupon_id in wishlist in shared prefrences in FAVITEMS
// 3. when log out clear this list 
// 4.when log in the user again to app , get the coupons id in his wishlist and save again.
// 5. when the get the status for item with wishlist , check from shared refreces ..

