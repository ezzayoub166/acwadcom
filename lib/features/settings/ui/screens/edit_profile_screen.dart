
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/settings/ui/widgets/build_abled_textfiled.dart';
import 'package:acwadcom/features/settings/ui/widgets/build_disabled_textfiled.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold (
      appBar: buildAppBarWithBackButton(context, isRTL(context)),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                      children: [
                        // CircleAvatar with image
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("assets/images/tow.jpeg"),
                        ),

                        // Positioned widget to place the edit icon at the bottom right
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              // Handle the image edit action here
                              print("Edit image tapped");
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors
                                  .blue, // Background color for edit icon circle
                              child: Icon(
                                Icons.edit, // The edit icon
                                color: Colors.white, // Icon color
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  Column(
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
                                ManagerValidator.validateEmail(value, context)),
                        buildSpacerH(10.0),
                        buildAbleTextField(
                            text: "972592661915",
                            validator: (value) =>
                                ManagerValidator.validateEmail(value, context)),
                        buildSpacerH(10.0),
                        RoundedButtonWgt(
                            height: 50.h,
                            fontSize: 20,
                            title: "Save",
                            onPressed: () {})
                      ],
                    )


            ]))));
  }
}