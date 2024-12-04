import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/settings/ui/screens/terms_condions.dart';
import 'package:flutter/gestures.dart';

class buildTermsAndCondtions extends StatelessWidget {

  final Color textColor;
  const buildTermsAndCondtions({
    super.key,  this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "By Signing up you accept all".tr(context),
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor ,
            ),
            children: [
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: 'terms & conditions'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  decoration: TextDecoration
                      .underline, // Adds underline
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Perform the action when 'privacy policies' is clicked
                       navigateTo(context,TermsAndConditionsScreen());
    
                    // You can navigate to another screen or show a dialog here
                  },
              ),
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                  text: '&',
                  style: TextStyle(
                      color: ManagerColors.yellowColor)),
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: 'privacy policies'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  decoration: TextDecoration
                      .underline, // Adds underline
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Perform the action when 'privacy policies' is clicked
                       navigateTo(context,TermsAndConditionsScreen());
                    // You can navigate to another screen or show a dialog here
                  },
              ),
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                  text: 'of Acwdcom!'.tr(context),
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ManagerColors.yellowColor,
                  ))
            ]));
  }
}