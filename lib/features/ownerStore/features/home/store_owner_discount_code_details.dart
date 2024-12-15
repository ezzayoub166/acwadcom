// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/user/settings/ui/widgets/build_disabled_textfiled.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/util/language_cache_helper.dart';
import 'package:acwadcom/models/coupon_model.dart';

import '../../../../common/widgets/build_remaing_time_for_coupon.dart';

class StoreOwnerDiscountCodeDetails extends StatelessWidget {
  const StoreOwnerDiscountCodeDetails({super.key, required this.coupon});
  final Coupon coupon;


  @override
  Widget build(BuildContext context) {
    var locale = LanguageCacheHelper().getCachedLanguageCode();
    DateTime endDate = (coupon.endData).toDate();
  String remainingTime = calculateTimeRemaining(endDate);
    return Scaffold(
      appBar:  buildAppBarWithBackButton(context, isRTL(context),
              title: AText.detilsDiscount.tr(context)),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
          child: ListView(
                children: [      
          buildSpacerH(10.0),
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: getIt<CacheHelper>().getValueWithKey("IMAGEURL"),
              width: 100,
              height: 100,
              fit: BoxFit.contain, // Ensures the image fits within the circle
            ),
          ),
          buildSpacerH(10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myText(coupon.title, fontSize: 16, fontWeight: FontWeight.bold),
              buildSpacerH(5.0),
              buildRemaingTimeForDiscountCode(context, remainingTime),
               buildSpacerH(10.0),

              buildDisabledTextField(text:coupon.code),
              buildSpacerH(10.0),
              buildDisabledTextField(text: "${coupon.discountRate}${AText.discontrate.tr(context)}"),
              buildSpacerH(10.0),
              buildDisabledTextField(text: coupon.storeLink),
              buildSpacerH(10.0),
              buildDisabledTextField(text: locale == "en" ? coupon.category?.title["en"] : coupon.category?.title["ar"]),
              buildSpacerH(10.0),
              buildDisabledTextField(text: "${coupon.numberOfUse}${AText.numberOfuse.tr(context)}"),
              buildSpacerH(10.0),
              AdditionalTermsCardWidget(text: coupon.additionalTerms)
              
              
            ],
          )
                ],
              ),
        ));
  }


}
