import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/coupons/ui/widgets/bottom_sheet_copun_deatils.dart';
import 'package:acwadcom/features/coupons/ui/widgets/build_app_bar_with_back_button.dart';

class CouponDeatlsScreen extends StatefulWidget {
  const CouponDeatlsScreen({super.key});

  @override
  State<CouponDeatlsScreen> createState() => _CouponDeatlsScreenState();
}

class _CouponDeatlsScreenState extends State<CouponDeatlsScreen> {
  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
        appBar: buildAppBarWithBackButton(context, isRtl),
        body: buildParent(context));
  }



  Padding buildParent(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          // alignment: Alignment.center,
          children: [
            svgImage("subtract", fit: BoxFit.fitHeight),
            Positioned.fill(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myImage("imgStore", height: 100.h, width: 100.w),
                  buildSpacerH(10),
                  Text("أوبر ",
                      style: Theme.of(context).textTheme.headlineSmall),
                  buildSpacerH(10),
                  Text("%0% كاش باك علي اي رحلة باستخدم الفيوا و المستر مارد",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge),
                  buildSpacerH(10),
                  Divider(
                    thickness: 1,
                  ),
                  buildSpacerH(10),
                  Text(AText.codeDicount.tr(context),
                      style: Theme.of(context).textTheme.bodyMedium),
                  buildSpacerH(10),
                  Text(
                    "STANDR 20",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: ManagerColors.yellowColor),
                  ),
                  buildSpacerH(10),
                  buildCopyButton(context),
                  buildSpacerH(10.0),
                  buildGoToStoreButton(context),
                  buildSpacerH(5.0),
                  Text(
                    "متاح حتي 14-4-2025",
                    style: TextStyle(color: ManagerColors.lightTextColor),
                  )
                ],
              ),
            ))
          ],
        ),
      );
  }

  SizedBox buildGoToStoreButton(BuildContext context) {
    return SizedBox(
                    width: 226.w,
                    height: 45.h,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2, color: Colors.white),
                        textStyle: GoogleFonts.cairo(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                      ),
                      onPressed: () {
                        // ** Go To Store Button
                      },
                      child: Text(
                        "Go To Store",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  );
  }

  RoundedButtonWgt buildCopyButton(BuildContext context) {
    return RoundedButtonWgt(
                    height: 45.h,
                    raduis: 4,
                    width: 226.w,
                    // width:  ,
                    title: "copy",
                    onPressed: () {
                      //** copy the code and show bottom sheet.. */
                      // Show Bottom Sheet on button press
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return BottomSheetContent();
                        },
                      );
                    },
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "copy",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                        buildSpacerW(3),
                        svgImage("copy", height: 24.h, width: 24.w),
                      ],
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: ManagerColors.kCustomColor,
                  );
  }

  // Define the bottom sheet content
}


