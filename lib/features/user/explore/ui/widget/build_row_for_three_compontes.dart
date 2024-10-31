
  import 'package:acwadcom/features/user/explore/ui/widget/build_attributes_widget.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_dashed_line.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_fav_and_copy_widget.dart';
import 'package:acwadcom/models/coupon_model.dart';

import '../../../../../acwadcom_packges.dart';

Widget buildRowForItems(context , Coupon coupon){
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BuildFavAndCopyWidget(coupon: coupon),
                buildDashedLine(),
                buildAttributesWgt(context,coupon),
              ],
            );
  }