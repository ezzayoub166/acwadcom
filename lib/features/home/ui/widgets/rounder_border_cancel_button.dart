
import 'package:acwadcom/acwadcom_packges.dart';

class RounderBorderCancelButton extends StatelessWidget {

  final double? height;
  final double? width;

  const RounderBorderCancelButton({
    super.key,
    this.height = 60,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
         backgroundColor: Colors.transparent,
         side: BorderSide(color: Colors.orange, width: 2), // Border color and width
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Rounded border
          ),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Padding
        ),
        onPressed: () {
          pop(context);
          // Action for the Cancel button
        },
        child: myText(
          AText.cancel.tr(context),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ManagerColors.yellowColor
            
          
        ),
      ),
    );
  }
}