import 'package:acwadcom/acwadcom_packges.dart';

Widget buildEmptyListCoupons(
  double screenWidth,
  double screenHeight,
  BuildContext context,
  String text,
) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Container for the icon/image
        Padding(
          padding: EdgeInsets.only(bottom: screenHeight * 0.01), // Adjusted spacing
          child: svgImage(
            "_icEmpty",
            size: screenWidth * 0.4, // Slightly reduced size for better layout
            height: screenWidth * 0.4,
          ),
        ),
        // Text with improved styling and spacing
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth * 0.045, // Slightly smaller for proportionality
            fontWeight: FontWeight.w500,
            color: Colors.grey[700], // Softer color for better aesthetics
          ),
        ),
      ],
    ),
  );
}
