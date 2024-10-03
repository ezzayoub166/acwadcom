import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:extended_image/extended_image.dart';

class DiscountCodeDeatilsAdmin extends StatelessWidget {
  const DiscountCodeDeatilsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: myText(AText.detilsDiscount.tr(context) , color: Colors.white , fontSize: 16  , fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: ManagerColors.kCustomColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Store Logo (Top Circle Avatar)
                     ClipOval(
            child: extendedImageWgt(
              "https://www.robotbutt.com/wp-content/uploads/2016/02/goodwill-logo.jpg",
              100,100
            ),
          ),
              SizedBox(height: 16),

              // Store Name
              Text(
                "اسم المتجر",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),

              // Fields (Discount code, Discount Percentage, Website link, etc.)
              buildInfoField(AText.discountcode.tr(context), "STANDR 20", context),
              buildInfoField(AText.discontrate.tr(context), "خصم 20%", context),
              buildInfoField(AText.linkofWebsite.tr(context), "https://mostaql.com/u/Ailee", context),
              buildInfoField(AText.category.tr(context), "أزياء", context),
              // buildInfoField(AText.stateData.tr(context), "2024-3-30", context),
              buildInfoField(AText.endDate.tr(context), "2024-3-30", context),

              // Notes Section
              buildNotesField(AText.someNotes.tr(context), "لا يجوز استخدام الفرد مرتين للاستخدام", context),
              
              SizedBox(height: 24),

              // Accept and Reject Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildActionButton("Accept".tr(context), ManagerColors.kCustomColor, context),
                  buildSpacerH(10.0),
                  buildActionButton("reject".tr(context), Colors.red, context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Method for Info Fields
  Widget buildInfoField(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myText(
            label,
        
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Method for Notes Field
  Widget buildNotesField(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myText(
            label,
       
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
        
          ),
          SizedBox(height: 8),
          Container(
            height: 100, // Fixed height for Notes Field
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Method for Action Buttons
  Widget buildActionButton(String label, Color color, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}