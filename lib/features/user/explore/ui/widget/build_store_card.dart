
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/explore/data/store_model.dart';
import 'package:acwadcom/models/user_model.dart';

class StoreCard extends StatelessWidget {
  
  final UserModel store ;

  const StoreCard({super.key, required this.store});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 90.h,
           // width: 130.w, // Fixed responsive width
          // width: double.infinity,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              myText(store.userName , fontSize: 15 , fontWeight: FontWeightEnum.Regular.fontWeight),
              myText(
                //!!! TODO create the deatis for store owner ,,,,, when create account
                "IN DEBUGIN........",
                  fontSize: 16.0,
                  color: Colors.grey[700],
                textAlign: TextAlign.center,
              ),

            ],
          ),
        ),
        Positioned(
          top:10,
          left: 30.w,
          right: 30.w,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: ManagerColors.kCustomColor,
             backgroundImage: store.profilePicture != "" ?  CachedNetworkImageProvider(store.profilePicture) : AssetImage("assets/images/user.png"),
                onBackgroundImageError: (error, stackTrace) {
                  print("Error loading image: $error");
                }
            ),
        ),
      ],
    );
  }
}