
import '../../../../../acwadcom_packges.dart';
import '../../../../../models/coupon_model.dart';
import '../../../coupons/ui/screens/coupon_deatls_screen.dart';
import 'build_featured_code.dart';

class BuildListCoupons extends StatelessWidget {
  final List<Coupon> coupons;
  const BuildListCoupons({
    super.key,
    required this.coupons,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          return InkWell(
              onTap: () {
                navigateTo(
                    context,
                    CouponDeatlsScreen(
                      coupon: coupons[index],
                    ));
              },
              child: BuildFeaturedCode(
                coupon: coupons[index],
              ));
        },
        separatorBuilder: (ctx, index) => buildSpacerH(10.0),
        itemCount: coupons.length);
  }
//flutter_spinkit: ^5.2.0
}
