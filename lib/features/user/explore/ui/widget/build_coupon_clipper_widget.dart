  import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_row_for_three_compontes.dart';
import 'package:acwadcom/helpers/custom_shapes/build_shape_1.dart';
import 'package:acwadcom/models/coupon_model.dart';

ClipPath buildCouponClipperItem(BuildContext context, Coupon coupon) {
    return ClipPath(
  clipper: CuponClipper(),
  child: Container(
    padding: const  EdgeInsets.fromLTRB(10,10,10,0),
    height: 110,
    // width: 400,
    alignment: Alignment.center,
    color: Colors.white,
    child: buildRowForItems(context, coupon) ,
  ),
);
  }