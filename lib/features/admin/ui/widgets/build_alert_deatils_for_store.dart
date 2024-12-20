  import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/models/coupon_model.dart';

Widget buildAlertDeatilsForStore(
      BuildContext context, Coupon coupon) {
    return AlertDialog(
      backgroundColor: ManagerColors.kCustomColor,
      content: Container(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                myImage("icon_app_acwdcom", height: 140, width: 150),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    myText(AText.phoneNumber.tr(context),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ManagerColors.yellowColor),
                    buildSpacerW(3.0),
                    Expanded(
                      child: myText(
                        fontSize: 10,
                        color: ManagerColors.whiteBtnBackGround,
                        "${coupon.ownerCoupon.phoneNumber}",
                      ),
                    ),
                    IconButton(
                      color: ManagerColors.yellowColor,
                      icon: Icon(
                        Icons.copy,
                      ),
                      onPressed: () {
                        //** copy the phone Number  for Coupon....... */
                        copyTextToClipboard(
                            coupon.ownerCoupon.phoneNumber, context);
                      },
                    )
                  ],
                ),
                buildSpacerH(10.0),
                // Coupon Owner
                Row(
                  children: [
                    myText(AText.storeName.tr(context),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ManagerColors.yellowColor),
                    buildSpacerW(3.0),
                    myText(
                      fontSize: 12,
                      color: ManagerColors.whiteBtnBackGround,
                      "${coupon.ownerCoupon.userName}",
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }