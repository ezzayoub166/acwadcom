// ignore_for_file: file_names

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:intl/intl.dart';

class BuildListMostUserCopuns extends StatelessWidget {
  const BuildListMostUserCopuns({
    super.key,
    required this.itemWidth,
    this.axis = Axis.horizontal,
    this.isExpanded = false, required this.coupons,
  });

  final double itemWidth;
  final Axis axis;
  final bool isExpanded;
  final List<Coupon> coupons;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: ListView.separated(
        scrollDirection: axis,
        itemCount: coupons.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (ctx, index) => buildSpacerH(20.0),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            width: itemWidth,
            height: 140.h,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildFavAndCopyWgt(context,coupons[index]),
                // buildSpacerH(3),
                buildDashedLine(),
                // buildSpacerH(3),
                buildAttributesWgt(context,coupons[index]),
              ],
            ),
          );
        },
      ),
    );
  }

  Flexible buildFavAndCopyWgt(BuildContext context , Coupon coupon) {
    return Flexible(
      flex: 2,
      child: Stack(
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Positioned(
              top: 10,
              left: 5,
              child: SvgPicture.asset("assets/images/_icFavorites.svg"),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height *
                    0.06, // 10% from the top of the screen
                left: MediaQuery.of(context).size.width *
                    0.02, //2% from the left of the parent
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myText("${coupon.discountRate}% ${AText.discountText.tr(context)}",
                        fontSize: 10,
                        fontWeight: FontWeightEnum.Bold.fontWeight),
                    buildSpacerH(5.0),
                    InkWell(
                      child: Container(
                        height: 25.h,
                        width: 50.w,
                        // padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        decoration: const BoxDecoration(
                            color: ManagerColors.yellowColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: myText(
                          AText.copy.tr(context),
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeightEnum.Bold.fontWeight,
                        )),
                      ),
                      onTap: () {},
                    ),
                  ],
                ))
          ]),
    );
  }

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
              Container(
                height: 30,
                width: 30,
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(15)),
                child: extendedImageWgt(coupon.storeLogoURL!),
              ),
              buildSpacerW(5),
              myText(coupon.title, color: ManagerColors.blackTextColorexploreItem),
              //
            ],
          ),
          myText(AText.codeDicount.tr(context),
              color: ManagerColors.blackTextColorexploreItem),
          //** Discount Code */
          myText(coupon.code,
              fontSize: 14,
              fontWeight: FontWeightEnum.SemiBold.fontWeight,
              color: ManagerColors.yellowColor),
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

  Flexible buildDashedLine() {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          buildSpacerH(2.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              15,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Container(
                  color: const Color(0xffDCDCDC),
                  height: 5.h,
                  width: 2.w,
                ),
              ),
            ),
          ),
          buildSpacerH(2.0.h),
        ],
      ),
    );
  }
}
