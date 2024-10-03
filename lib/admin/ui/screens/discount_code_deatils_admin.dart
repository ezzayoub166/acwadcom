import 'package:acwadcom/acwadcom_packges.dart';

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
            child: Image.network(
              "https://www.robotbutt.com/wp-content/uploads/2016/02/goodwill-logo.jpg",
              width: 100,
              height: 100,
              fit: BoxFit.contain, // Ensures the image fits within the circle
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
              buildInfoField("اسم كود الخصم", "STANDR 20", context),
              buildInfoField("نسبة الخصم", "خصم 20%", context),
              buildInfoField("رابط الموقع", "https://mostaql.com/u/Ailee", context),
              buildInfoField("التصنيف", "أزياء", context),
              buildInfoField("تاريخ البدأ", "2024-3-30", context),
              buildInfoField("تاريخ الانتهاء", "2024-3-30", context),

              // Notes Section
              buildNotesField("ملاحظات", "لا يجوز استخدام الفرد مرتين للاستخدام", context),
              
              SizedBox(height: 24),

              // Accept and Reject Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildActionButton("قبول", Colors.green, context),
                  buildSpacerH(10.0),
                  buildActionButton("رفض", Colors.red, context),
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