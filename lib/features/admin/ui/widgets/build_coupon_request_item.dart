import 'package:acwadcom/acwadcom_packges.dart';

class CouponRequestItem extends StatelessWidget {
  final String logoPath;
  final String storeName;
  final String discountCode;
  final String time;
  final VoidCallback onView;
  final VoidCallback onIgnore;

  CouponRequestItem({
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
                image: CachedNetworkImageProvider(
                    logoPath), // Use your actual asset path
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
                 Text.rich(TextSpan(children: [
                  TextSpan(text: AText.thereRquest.tr(context) , style: TextStyleFont14(
                    color: ManagerColors.kCustomColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  )),
                  const TextSpan(text: " "),
                   TextSpan(text: discountCode , style: TextStyleFont14(
                    color: ManagerColors.yellowColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  )),
                 ]
                )),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  Row(
                    children: [
                         InkWell(
                      onTap: onView,
                      child: myText(
                        "see".tr(context),
                          fontSize: 18,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                    const SizedBox(width: 30),
                    InkWell(
                      onTap: onIgnore,
                      child: myText(
                        "reject".tr(context),
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                      ),
                    ),
                    ],
                  )
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
