
  import 'package:acwadcom/acwadcom_packges.dart';

Widget buildEmptyListCoupons(
 double screenWidth,
 double screenHeight,
 BuildContext context,
 String text
 ){
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container for the icon image on top
            SizedBox(
              height: screenHeight * 0.5, // Responsive sizing
              width: screenWidth * 0.5,
              // decoration: BoxDecoration(
              //   color: Colors.orangeAccent,
              //   borderRadius: BorderRadius.circular(12),
              // ),
              child: svgImage(
                "_icEmpty",
                size: screenWidth * 0.5,
                height: screenWidth * 0.5, // Responsive sizing
              ),
            ),
            const SizedBox(height: 24),
            // Main title text
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            )
          ]
          );
  }