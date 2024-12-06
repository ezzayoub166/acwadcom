
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/features/user/explore/data/store_model.dart';
import 'package:acwadcom/models/user_model.dart';

class StoreCard extends StatelessWidget {
  
  final UserModel store ;

  const StoreCard({super.key, required this.store});
  @override
  Widget build(BuildContext context) {
    return 
        Container(
          height: 120,
           width: 130.w, // Fixed responsive width
          // width: double.infinity,
          // padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.grey , width: 0.5)
          ),
          child: Column(
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius as needed
                  ),
                  clipBehavior: Clip.antiAlias,
                  elevation: 0.0,
                  child: extendedImageWgt(
                      store.profilePicture, 100, 140, BoxFit.cover)),
              Expanded(
                child: Column(
                  children: [
                    myText(store.userName , fontSize: 15 , fontWeight: FontWeightEnum.SemiBold.fontWeight),
                    buildSpacerH(5.0),
                    myText(
                  //!!! TODO create the deatis for store owner ,,,,, when create account
                  store.deatilsForStore??"أكواد خصم تصل إلى %",
                    fontSize: 12.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    
                    color: Colors.grey[700],
                  textAlign: TextAlign.center,
                ),
                  ],
                ),
              ),
              
          ]
    ));
  }
}