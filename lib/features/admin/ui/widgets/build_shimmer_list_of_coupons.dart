 import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/shimmer/shimmer_loading.dart';

ListView buildShimmerListOfCoupons() {
    return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return CouponShimerLoader();
                  },
                  separatorBuilder: (ctx, index) => buildSpacerH(10.0),
                  itemCount: 5);
  }