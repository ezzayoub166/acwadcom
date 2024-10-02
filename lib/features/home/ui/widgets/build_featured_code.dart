import 'package:acwadcom/app_localizations.dart';
import 'package:acwadcom/helpers/constants/colors.dart';
import 'package:acwadcom/helpers/constants/strings.dart';
import 'package:acwadcom/helpers/widgets/common/svgImageWgt.dart';
import 'package:acwadcom/ownerStore/features/home/widgets/custom_pop_dialog_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildFeaturedCode extends StatelessWidget {

  final bool isShowRemove  ;
  const BuildFeaturedCode({
    this.isShowRemove = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120.h,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xffF2F2F2), width: 2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //image of store ....
            Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                  color: ManagerColors.greyLighColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: myImage("icNike")),
            ),
         
            //attributes => name of store , dicsount % , numer of use times ..
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Nike",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ManagerColors.textColorDark),
                ),
                Text(
                  "15% ${AText.discount.tr(context)}",
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
                              .copyWith(
                                  color: ManagerColors.textColor))
                    ])),
                  ],
                ),

              ],
            ),
                               //Favorite button..
            isShowRemove  ?  InkWell(
              child: svgImage("_icRemove", height: 20, width: 20),
              onTap: () {
                showConfirmDeleteDialog(context, "دايدس ");
              },
            ) : InkWell(
              child: svgImage("_icFavorites", height: 20, width: 20),
              onTap: () {},
            ) 
          ],
        ));
  }

  // Function to show the dialog
void showConfirmDeleteDialog(BuildContext context, String codeName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmDeleteDialog(codeName: codeName);
    },
  );
}
}
