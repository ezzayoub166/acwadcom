// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';


class MerchantStatisticsPage extends StatelessWidget {
  const MerchantStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithBackButton(context, isRTL(context),
              title: AText.statistics.tr(context)),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Merchant Info Section
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                          CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black,
                  child: Text(
                    "فوقا كلاسيت",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                buildSpacerW(20.0),
                    myText(
                      "فوقا كلاسيت",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                    ),
                  ],
                ),
          
              ],
            ),
            SizedBox(height: 24),
            
            // Section: Merchant Statistics Title
            myText(
             "Store statistics".tr(context),
                fontSize: 24,
                fontWeight: FontWeight.bold,
            
            ),
            SizedBox(height: 16),
            
            // // Customer Rating Card
            // Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           "(223) 4.0",
            //           style: TextStyle(
            //             fontSize: 20,
            //           ),
            //         ),
            //         SizedBox(width: 8),
            //         Icon(
            //           Icons.star,
            //           color: Colors.orange,
            //           size: 24,
            //         ),
            //         SizedBox(width: 8),
            //         Text(
            //           "متوسط تقييمات العملاء",
            //           style: TextStyle(fontSize: 16),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 16),

            // Discount Codes Count Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    myText(
                     AText.numberOfdiscountcodes.tr(context),
                      fontSize: 16,
                      color: ManagerColors.yellowColor
                    ),
                    myText(
                      "10",
                      
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                    
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Discount Code Usage Count Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        myText(
                         AText.numberOfuse.tr(context),
                         fontSize: 16,
                         color: ManagerColors.yellowColor
                        ),
                        myText(
                          "100",
                          
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}