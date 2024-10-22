import 'package:acwadcom/acwadcom_packges.dart';

Widget emptyWishList(BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: svgImage("heart")),
        buildSpacerH(5.0),
        myText(AText.emptyWishList.tr(context) , 
        textAlign: TextAlign.center,
        fontSize: 20,
        fontWeight: FontWeightEnum.Bold.fontWeight,
        maxLines: 2,
        ),
        buildSpacerH(5.0),
        myText(
          AText.followTohaveWishList.tr(context) , 
          textAlign: TextAlign.center,
        color: ManagerColors.lighTextForWishList,
        fontWeight: FontWeightEnum.Regular.fontWeight,
        fontSize: 14
        ),
        // buildSpacerH(10.0),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 40 , vertical: 10),
        //   child: RoundedButtonWgt(
        //     height: 60,
        //     backgroundColor: ManagerColors.kCustomColor,
        //     title: AText.browsetheStores.tr(context), onPressed: (){

        //     }),
        // )
    
    
      ],
    ),
  );
}