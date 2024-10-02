import 'package:acwadcom/app_localizations.dart';
import 'package:acwadcom/common/widgets/build_spacer_height.dart';
import 'package:acwadcom/common/widgets/rounded_button_widget.dart';
import 'package:acwadcom/helpers/Routing/routes.dart';
import 'package:acwadcom/helpers/constants/colors.dart';
import 'package:acwadcom/helpers/constants/strings.dart';
import 'package:acwadcom/helpers/util/extenstions.dart';
import 'package:acwadcom/helpers/widgets/common/svgImageWgt.dart';
import 'package:acwadcom/ownerStore/features/authitcation/ui/register_owner_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChosenStatusScreen extends StatefulWidget {
  const ChosenStatusScreen({super.key});
  

  @override
  State<ChosenStatusScreen> createState() => _ChosenStatusScreenState();
}

class _ChosenStatusScreenState extends State<ChosenStatusScreen> {

  Widget buildBtn(String title , VoidCallback onPressed , Color backgroundColor , Color foregroundColor){
    return SizedBox(
        height: 60.h,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
          ),
          child: Text(
            title
          ),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManagerColors.kCustomColor,
      body: Padding(
        // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              myImage("onBoarding_image_tow",height: 294.h , width: double.infinity),
              RoundedButtonWgt(title: AText.user.tr(context) , onPressed: (){
                navigateNamedTo(context, Routes.loginScreen , "User");
              }),
              buildSpacerH(20),
              RoundedButtonWgt(title: AText.shopOwner.tr(context) , backgroundColor: ManagerColors.whiteBtnBackGround ,foregroundColor: Colors.black , onPressed: (){
                //TODO:: for Shop owner not complete ...
                // navigateTo(context, RegisterOwnerStore());
                 navigateNamedTo(context, Routes.loginScreen , "ShopOwner");



              }),
            ],
          ),
        ),
      ),
    );
  }
}