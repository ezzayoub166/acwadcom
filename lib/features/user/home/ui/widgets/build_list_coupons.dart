

import 'package:acwadcom/common/widgets/build_remaing_time_for_coupon.dart';
import 'package:acwadcom/features/user/wishlist/logic/coupons_wishlist/cubit/wihslist_coupons_cubit.dart';
import 'package:lottie/lottie.dart';

import '../../../../../acwadcom_packges.dart';
import '../../../../../models/coupon_model.dart';
import '../../../coupons/ui/screens/coupon_deatls_screen.dart';
import 'build_featured_code.dart';

class BuildListCoupons extends StatefulWidget {
  final List<Coupon> coupons;
  final bool isScroll ; 
  const BuildListCoupons({
    super.key,
    required this.coupons, this.isScroll = false,
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

  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: widget.isScroll ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          DateTime endDate = (widget.coupons[index].endData).toDate();
          String remainingTime = calculateTimeRemaining(endDate);
          return InkWell(
            onLongPress: (){
              buildShowTimeRemainigDialog(context, remainingTime);

            },
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

  Future<dynamic> buildShowTimeRemainigDialog(BuildContext context, String remainingTime) {
    return showDialog(context: context, builder: (BuildContext dialogContext){
              return AlertDialog(
                backgroundColor: ManagerColors.kCustomColor,
                content: ConstrainedBox(
                    // height: 200.h,
                    // width: MediaQuery.of(context).size.width*0.5,
                       constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6, // Limit height
          ),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              myImage("icon_app_acwdcom" , height: 140,width: 150),
                              myText(AText.remaingTimeForDiscountCode.tr(context),
                                  fontSize: 18, color: ManagerColors.yellowColor),
                              Text(
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16, color: ManagerColors.whiteBtnBackGround
                                ),
                                remainingTime,
                              ),

                        ],
                      ),
                    )),
              );
            });
  }
}
