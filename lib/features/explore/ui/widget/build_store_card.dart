
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/explore/data/store_model.dart';

class StoreCard extends StatelessWidget {
  
  final StoreModel store ;

  const StoreCard({super.key, required this.store});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
         width: 120.w, // Fixed responsive width
      height: 160.h, // Fixed responsive height
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 150.h,
             width: 130.w, // Fixed responsive width
            // width: double.infinity,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                myText(store.name , fontSize: 15 , fontWeight: FontWeightEnum.Regular.fontWeight),
                myText(
                  store.deatilsForCopunns,
                    fontSize: 16.0,
                    color: Colors.grey[700],
                  textAlign: TextAlign.center,
                ),
              
              ],
            ),
          ),
          Positioned(
            top:1,
            left: 30.w,
            right: 30.w,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: ManagerColors.kCustomColor,
               backgroundImage: CachedNetworkImageProvider(store.imageUrl),
                  onBackgroundImageError: (error, stackTrace) {
                    print("Error loading image: $error");
                  }
              ),
          ),
        ],
      ),
    );
  }
}