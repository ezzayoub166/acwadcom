import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/admin/ui/screens/edit_code_screen_admin.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/ownerStore/features/home/widgets/custom_pop_dialog_delete.dart';

class BuildItmCodeForAdmin extends StatelessWidget {
  final Coupon coupon;
  const BuildItmCodeForAdmin({
    super.key,
    required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xffF2F2F2), width: 2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //image of store ....
            // Container(
            //   height: 120,
            //   width: 120,
            //   decoration: BoxDecoration(
            //       color: ManagerColors.greyLighColor,
            //       borderRadius: BorderRadius.circular(10)),
            //   child: Center(child: myImage("icNike")),
            // ),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Adjust the radius as needed
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 5.0,
                child: extendedImageWgt(coupon.storeLogoURL??"",100,100,BoxFit.cover)
                
              ),

            //attributes => name of store , dicsount % , numer of use times ..
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    myText(coupon.title,
                        color: ManagerColors.textColorDark, fontSize: 18),
                        // buildSpacerW(10),
                    // buildSpacerW(MediaQuery.of(context).size.width /5),
                    InkWell(
                      child: svgImage("_icRemove", height: 20, width: 20),
                      onTap: () {
                        showConfirmDeleteDialog(context: context, couponID:  coupon.couponId , codeName:  coupon.title);
                      },
                    )
                  ],
                ),
                myText("15% ${AText.discount.tr(context)}",
                    color: ManagerColors.kCustomColor,
                    fontWeight: FontWeightEnum.Bold.fontWeight,
                    fontSize: 20),
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
                                  color: ManagerColors.textColorDarkDouble)),
                      TextSpan(
                          text: ":",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: ManagerColors.textColorDarkDouble)),
                      TextSpan(
                          text: " 2389",
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
          ],
        ));
  }

  // Function to show the dialog
  void showConfirmDeleteDialog(
     { required BuildContext context, required String couponID, required String codeName}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          codeName: codeName,
          couponID: couponID,
        );
      },
    );
  }
}
