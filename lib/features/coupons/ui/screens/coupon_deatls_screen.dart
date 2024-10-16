import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/features/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CouponDeatlsScreen extends StatefulWidget {


  final Coupon coupon;
  const CouponDeatlsScreen({super.key, required this.coupon});

  @override
  State<CouponDeatlsScreen> createState() => _CouponDeatlsScreenState();
}

class _CouponDeatlsScreenState extends State<CouponDeatlsScreen> {
  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
        appBar: buildAppBarWithBackButton(context, isRtl),
        body: Align(
          alignment: Alignment.topCenter,
          child: buildParent(context)));
  }
  // Function to copy the discount code
void copyToClipboard(String discountCode, BuildContext context) {
  Clipboard.setData(ClipboardData(text: discountCode)); // Copy to clipboard
  TLoader.showSuccessSnackBar(context, title: "Code copied".tr(context));
}



  Stack buildParent(BuildContext context) {
    return Stack(
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
               Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(15), // Adjust the radius as needed
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 5.0,
            child: extendedImageWgt(widget.coupon.storeLogoURL??"",120,140,BoxFit.cover)
            
          ),
              // myImage("imgStore", height: 100.h, width: 100.w),
              buildSpacerH(10),
              Text(widget.coupon.title,
                  style: Theme.of(context).textTheme.headlineSmall),
              buildSpacerH(10),
              Text(widget.coupon.additionalTerms,
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
                widget.coupon.code,
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
               Text.rich(
                TextSpan(children: [
                  TextSpan(text: "متاح حتى",style: TextStyle(color: ManagerColors.lightTextColor)),
                  TextSpan(text: "${widget.coupon.endData.toDate()}")
    
                ])
                // child: Text(
                //   "متاح حتي 14-4-2025",
                //   style: TextStyle(color: ManagerColors.lightTextColor),
                // ),
              )
            ],
          ),
        ))
      ],
    );
  }
      // Function to open URL
  void _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url); // Ensure the URL is parsed correctly

    if (await canLaunchUrl(uri)) {
      // Open the URL in the browser
      await launchUrl(uri, mode: LaunchMode.externalApplication); 
    } else {
      // If the URL cannot be opened, show an error
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Could not open the link!')),
      // );
      return TLoader.showErrorSnackBar(context, title: 'Could not open the link!');
    }
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
                        _launchURL(context,widget.coupon.storeLink);

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
                      copyToClipboard(widget.coupon.code, context);
                      // Show Bottom Sheet on button press
                      // showModalBottomSheet(
                      //   context: context,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.vertical(
                      //       top: Radius.circular(20),
                      //     ),
                      //   ),
                      //   builder: (context) {
                      //     return BottomSheetContent();
                      //   },
                      // );
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


