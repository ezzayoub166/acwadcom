// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/settings/ui/widgets/build_abled_textfiled.dart';
import 'package:acwadcom/features/settings/ui/widgets/build_disabled_textfiled.dart';

class ProfileScreen extends StatelessWidget {
  final bool isEdit;
  const ProfileScreen({super.key, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      appBar: buildAppBarWithBackButton(context, isRtl ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/tow.jpeg")),
              myText(
                "Izzdine Atallah",
                fontSize: 16,
                color: ManagerColors.kCustomColor,
                fontWeight: FontWeightEnum.Bold.fontWeight,
              ),
              buildSpacerH(5.0),
              myText(AText.user.tr(context),
                  fontSize: 16,
                  fontWeight: FontWeightEnum.Bold.fontWeight,
                  color: ManagerColors.yellowColor),
              buildSpacerH(10.0),
              !isEdit
                  ? Column(
                      children: [
                        buildDisabledTextField(text: "Izzdin Atallah"),
                        buildSpacerH(10.0),
                        buildDisabledTextField(text: "ezzdine484@gmail.com"),
                        buildSpacerH(10.0),
                        buildDisabledTextField(text: "972592661915"),
                        buildSpacerH(10.0),
                        RoundedButtonWgt(title: AText.logOut.tr(context ), onPressed: (){
                           navigateAndFinishNamed(context, Routes.chosenStatusScreen);
                        })
                      ],
                    )
                  : Column(
                      children: [
                        buildAbleTextField(
                            text: "Izzdine Atallah",
                            validator: (value) =>
                                ManagerValidator.validateEmptyText(
                                    "Name", "Izzdine Atallah")),
                        buildSpacerH(10.0),
                        buildAbleTextField(
                            text: "ezzdine484@gmail.com",
                            validator: (value) =>
                                ManagerValidator.validateEmail(value,context)),
                        buildSpacerH(10.0),
                        buildAbleTextField(
                            text: "972592661915",
                            validator: (value) =>
                                ManagerValidator.validateEmail(value,context)),
                                buildSpacerH(10.0),
                        RoundedButtonWgt(
                          height: 50.h ,
                          fontSize: 20,
                          title: "Save",  onPressed: (){})        
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
