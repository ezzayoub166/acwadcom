

import 'package:acwadcom/features/user/wishlist/logic/coupons_wishlist/cubit/wihslist_coupons_cubit.dart';

import '../../../../../acwadcom_packges.dart';
import '../../../../../models/coupon_model.dart';
import '../../../coupons/ui/screens/coupon_deatls_screen.dart';
import 'build_featured_code.dart';

class BuildListCoupons extends StatefulWidget {
  final List<Coupon> coupons;
  const BuildListCoupons({
    super.key,
    required this.coupons,
  });

  @override
  State<BuildListCoupons> createState() => _BuildListCouponsState();
}

class _BuildListCouponsState extends State<BuildListCoupons> {

  @override
  void initState() {
    // TODO: implement init State...
    super.initState();
    ///!! important i called the wishlist in here ,,, in list of Coupons ... 
    ///** so not call again in wishlist Screen or home screen or in wishlistCoupons Widget */

  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          return InkWell(
              onTap: () {
                navigateTo(
                    context,
                    CouponDeatlsScreen(
                      coupon: widget.coupons[index],
                    ));
              },
              child: BuildFeaturedCode(
                coupon: widget.coupons[index],
              ));
        },
        separatorBuilder: (ctx, index) => buildSpacerH(10.0),
        itemCount: widget.coupons.length);
  }
}
