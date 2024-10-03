import 'package:acwadcom/acwadcom_packges.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String logoPath;
  final String storeName;
  final String discountCode;
  final String time;
  final VoidCallback onView;
  final VoidCallback onIgnore;

  NotificationItem({
    required this.logoPath,
    required this.storeName,
    required this.discountCode,
    required this.time,
    required this.onView,
    required this.onIgnore,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          
          // Logo
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: CachedNetworkImageProvider(logoPath), // Use your actual asset path
                fit: BoxFit.contain,
              ),
            ),
          ),

          buildSpacerW(10),

          // Notification Text and Actions
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myText(
                  'هناك طلب بإضافة كود خصم $discountCode',
                  
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: ManagerColors.kCustomColor
                  
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: onView,
                      child: Text(
                        'الاطلاع',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    InkWell(
                      onTap: onIgnore,
                      child: Text(
                        'تجاهل',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
       

          // Status Indicator (Green dot)
          const Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.circle,
              color: Colors.green,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
} // Assuming you have this file

class RequestScreenAdmin extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'logo': "https://img.freepik.com/free-vector/gradient-instagram-shop-logo-template_23-2149704603.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727308800&semt=ais_hybrid", // Use correct image path
      'store': 'Pizza Hut',
      'discountCode': 'STANDR 20',
      'time': 'منذ ساعتين',
    },
    {
      'logo': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHuSKg3KQINvWnpNkd9brsgcZmMyjYIeuNjQ&s",
      'store': 'Boston Pizza',
      'discountCode': 'STANDR 20',
      'time': 'منذ ساعتين',
    },
    {
      'logo': "https://www.robotbutt.com/wp-content/uploads/2016/02/goodwill-logo.jpg",
      'store': 'Chili\'s',
      'discountCode': 'STANDR 20',
      'time': 'منذ ساعتين',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ManagerColors.kCustomColor,
        title: myText(AText.requestOkay.tr(context) , color: Colors.white , fontSize: 16, fontWeight: FontWeight.bold),centerTitle: true,),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationItem(
            logoPath: notification['logo']!,
            storeName: notification['store']!,
            discountCode: notification['discountCode']!,
            time: notification['time']!,
            onView: () {
              // Handle view action
              navigateNamedTo(
                            context, Routes.discountCodeDeatilsAdmin);
            },
            onIgnore: () {
              // Handle ignore action
            },
          );
        },
      ),
    );
  }
}