
  import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:intl/intl.dart';

Flexible buildAttributesWgt(BuildContext context , Coupon coupon) {
     String formattedDate = DateFormat('dd/MM/yyyy').format(coupon.endData.toDate());
    return Flexible(
      flex: 6,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //ic Logo..
              CircleAvatar(
                radius: 15,
                backgroundImage: CachedNetworkImageProvider(coupon.storeLogoURL!),
              ),
              buildSpacerW(5),
              myText(coupon.title, color: ManagerColors.blackTextColorexploreItem),
              //
            ],
          ),
          Row(
            children: [
                        myText(AText.codeDicount.tr(context),
              color: ManagerColors.blackTextColorexploreItem),
                            myText(":"),

              buildSpacerW(5.0),
          //** Discount Code */
          myText(coupon.code,
              fontSize: 14,
              fontWeight: FontWeightEnum.Bold.fontWeight,
              color: ManagerColors.yellowColor),
            ],
          ),

          //** deatils of Code. */
          myText(coupon.additionalTerms,
          maxLines: 1,
          overflow:TextOverflow.ellipsis,
          
              fontSize: 14, fontWeight: FontWeightEnum.Regular.fontWeight),

          Row(
            children: [
              svgImage("_icClockfilled", width: 14, height: 14),
              buildSpacerW(2),
              myText(AText.endDate.tr(context),
                  fontSize: 14, color: Colors.green),
              buildSpacerW(2),
              myText(formattedDate)
            ],
          )
        ],
      ),
    );
  }