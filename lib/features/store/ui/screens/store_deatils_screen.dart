import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/explore/data/store_model.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';

class StoreDeatilsScreen extends StatelessWidget {

  final StoreModel store;
  const StoreDeatilsScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
        final double itemWidth = MediaQuery.of(context).size.width * 0.2;

    return Scaffold(
    
      backgroundColor: Color(0xffF5F5F5),
      body:Stack(

        alignment: Alignment.topCenter,
        children: [
     
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: ManagerColors.kCustomColor,
              height: 200.h,
              width: double.infinity,
            ),
          ),
              Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: ManagerColors.kCustomColor,
              leading: Padding(
          padding: EdgeInsets.only(
            left: Localizations.localeOf(context).languageCode == 'ar'
                ? 0
                : 16, // Padding for English
            right: Localizations.localeOf(context).languageCode == 'ar'
                ? 16
                : 0, // Padding for Arabic
          ),
          child: InkWell(
            child: svgImage("arrow-circle-left", isRtl: isRTL(context)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
           Padding(
            padding: const EdgeInsets.only(
            left:  16, // Padding for English
            right: 16 // Padding for Arabic
          ),
             child: InkWell(
              child: svgImage("_icGrayHeart", isRtl: isRTL(context)),
              onTap: () {
                //** TOTO heart Store.... */
                // Navigator.pop(context);
              },
                       ),
           ),
        ],
            )
             ),
          Positioned.fill(
            left: 20,
            right: 20,
            top: 130.h,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               CircleAvatar(
                radius: 60.r,
                backgroundColor: ManagerColors.kCustomColor,
                backgroundImage: NetworkImage(store.imageUrl)
                ),
                myText(store.name , fontSize: 18 , fontWeight: FontWeight.bold,color: ManagerColors.kCustomColor),
                BuildListMostUserCopuns(itemWidth: itemWidth , axis: Axis.vertical,isExpanded: true,)
               
            ],
          ))
        ],
      )
    );
  }
}