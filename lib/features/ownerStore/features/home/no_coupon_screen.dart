import 'package:acwadcom/acwadcom_packges.dart';

class NoCouponsScreen extends StatelessWidget {
  const NoCouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define screen size for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;

    return  Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container for the icon image on top
              SizedBox(
                height: screenWidth * 0.5, // Responsive sizing
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
                "There are no coupons for your store".tr(context),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              // Subtitle text
              Text(
                "Add coupons and increase your sales now".tr(context),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              // Button to add a new code
              ElevatedButton.icon(
                onPressed: () {
                  // Action for adding a new coupon
                navigateNamedTo(context, Routes.createCodeForUserScreen);
                },
                
                icon: svgImage("add-circle"),
                label: Text(
                 "Add new code".tr(context),
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xffFFEABB),// Button background color
                  foregroundColor: Colors.black, // Button text color
                ),
                
              ),
            ],
          ),
        ),
    );
  }
}