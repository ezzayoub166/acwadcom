// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/settings/ui/widgets/build_disabled_textfiled.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';

class StoreOwnerDiscountCodeDetails extends StatelessWidget {
  const StoreOwnerDiscountCodeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  buildAppBarWithBackButton(context, isRTL(context),
              title: AText.detilsDiscount.tr(context)),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
          child: ListView(
                children: [      
          buildSpacerH(10.0),
          ClipOval(
            child: Image.network(
              "https://www.robotbutt.com/wp-content/uploads/2016/02/goodwill-logo.jpg",
              width: 100,
              height: 100,
              fit: BoxFit.contain, // Ensures the image fits within the circle
            ),
          ),
          buildSpacerH(10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myText("فوكس بوكس ", fontSize: 16, fontWeight: FontWeight.bold),
              buildSpacerH(5.0),
              myText("متبقي لانتهاء كود الخصم 20 يوم",
                  fontSize: 14, color: ManagerColors.yellowColor),
                                buildSpacerH(10.0),

              buildDisabledTextField(text: "STANDR 20"),
              buildSpacerH(10.0),
              buildDisabledTextField(text: " خصم 20%"),
              buildSpacerH(10.0),
              buildDisabledTextField(text: "https://mostaql.com/u/Ailee"),
              buildSpacerH(10.0),
              buildDisabledTextField(text: "أزياء"),
              buildSpacerH(10.0),
              buildDisabledTextField(text: "22 مرات الاستخدام"),
              buildSpacerH(10.0),
              AdditionalTermsCardWidget()
              
              
            ],
          )
                ],
              ),
        ));
  }
}
