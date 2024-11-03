import 'package:acwadcom/acwadcom_packges.dart';

class FeaturedNotAvalibleDialog extends StatefulWidget {
  const FeaturedNotAvalibleDialog({super.key});

  @override
  State<FeaturedNotAvalibleDialog> createState() => _FeaturedNotAvalibleDialogState();
}

class _FeaturedNotAvalibleDialogState extends State<FeaturedNotAvalibleDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon at the top
          SizedBox(
            width: 100,
              height: 100,
            child: svgImage(
              "icBuildLogo",
              fit: BoxFit.fill
              
            ),
          ),
          SizedBox(height: 16),
          
          // Confirmation Text
          myText(
            "This feature is not available in this version. It will be available in the next version. Thank you!".tr(context),
            textAlign: TextAlign.center,
              fontSize: 16,
              fontWeight: FontWeightEnum.ExtraLight.fontWeight,
              color: Colors.black,
          ),
          SizedBox(height: 20)
        ]
      ));
  }
}