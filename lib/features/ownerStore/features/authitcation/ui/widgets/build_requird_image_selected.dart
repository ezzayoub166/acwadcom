import 'package:acwadcom/acwadcom_packges.dart';

class RequiredImageSelectedWgt extends StatelessWidget {
  const RequiredImageSelectedWgt({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ManagerColors.kCustomColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.all(24),
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
           "You must attach a photo or logo to the store".tr(context),
            textAlign: TextAlign.center,
            
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
          )
        ]
      ) 
          );
  }
}