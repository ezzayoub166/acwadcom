import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/features/ownerStore/features/home/widgets/custom_pop_dialog_delete.dart';

class BuildFeaturedCode extends StatelessWidget {
  final Coupon coupon;

  final bool isShowRemove;
  const BuildFeaturedCode({
    this.isShowRemove = false,
    super.key,
    required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xffF2F2F2), width: 2)),
        child: Row(
          children: [
            //image of store ....
            Expanded(
              flex:4,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Adjust the radius as needed
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 5.0,
                child: extendedImageWgt(coupon.storeLogoURL??"",100,140,BoxFit.cover)
                
              ),
            ),

            buildSpacerW(10),
            Expanded(
              flex: 9,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //attributes => name of store , dicsount % , numer of use times ..
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      myText(
                        coupon.title,
                        color: ManagerColors.textColorDark,
                        fontSize: 16.sp,
                        maxLines: 2,
                        fontWeight: FontWeightEnum.Bold.fontWeight,
                        overflow: TextOverflow.ellipsis,
                        
                      ),
                      Text(
                        "${coupon.discountRate}% ${AText.discount.tr(context)}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: ManagerColors.kCustomColor),
                      ),
                      Row(
                        children: [
                          svgImage("profile-tick", height: 18, width: 18),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: AText.numberOfuse,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color:
                                            ManagerColors.textColorDarkDouble)),
                            TextSpan(
                                text: ":",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color:
                                            ManagerColors.textColorDarkDouble)),
                            TextSpan(
                                text: " 100",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: ManagerColors.textColor))
                          ])),
                        ],
                      ),
                    ],
                  ),
                  //Favorite button..
                  isShowRemove
                      ? InkWell(
                          child: svgImage("_icRemove", height: 20, width: 20),
                          onTap: () {
                            showConfirmDeleteDialog(context, coupon.title);
                          },
                        )
                      : InkWell(
                          child:
                              svgImage("_icFavorites", height: 20, width: 20),
                          onTap: () {},
                        )
                ],
              ),
            ),
          ],
        ));
  }

  // Function to show the dialog
  void showConfirmDeleteDialog(BuildContext context, String codeName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(codeName: codeName, couponID: coupon.couponId,);
      },
    );
  }
}
