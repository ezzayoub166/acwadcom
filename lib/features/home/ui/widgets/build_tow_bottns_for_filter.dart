

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/home/ui/widgets/rounder_border_cancel_button.dart';

class ButtonRowApplyCancle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        // Cancel Button (Outlined)
        RounderBorderCancelButton(
          height: 60.h,
          width: 140.w,
        ),
        SizedBox(width: 10), // Spacing between buttons
        // Apply Button (Filled)
        SizedBox(
          height: 60.h,
          width: 140.w,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ManagerColors.yellowColor, // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Rounded border
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Padding
            ),
            onPressed: () {
              // Action for the Apply button
            },
            child: Text(
              AText.apply.tr(context),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color
              ),
            ),
          ),
        ),
      ],
    );
  }
}
