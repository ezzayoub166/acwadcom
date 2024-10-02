import 'package:acwadcom/acwadcom_packges.dart';

class RevisonResponseScreen extends StatelessWidget {
  const RevisonResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgImage("_imgCallCenter",width: 200.w),
            buildSpacerH(10.0),
            myText(AText.yourRequestIsBeingReviewed.tr(context),fontSize: 20 , fontWeight: FontWeightEnum.Bold.fontWeight,color: ManagerColors.kCustomColor),
            buildSpacerH(10.0),
            myText(AText.satisfactionMessage.tr(context),fontSize: 14 ,textAlign: TextAlign.center, fontWeight: FontWeightEnum.Regular.fontWeight,color: ManagerColors.kCustomColor),
            buildSpacerH(10.0),
            RoundedButtonWgt(title: AText.goToHome.tr(context), onPressed: (){
              navigateNamedTo(context, Routes.bottomTabBarScreen);
            } , height: 50,)
        
        
        
        
        
          ],
        ),
      ),
    );
  }
}