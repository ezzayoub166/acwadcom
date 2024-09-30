

import 'package:acwadcom/acwadcom_packges.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

 
Widget buildRegisterNewAccount(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center, //For horizantol
    mainAxisSize: MainAxisSize.max,
    children: [
            Flexible(
        child: myText(
          AText.nohaveAccount.tr(context),
          textAlign: TextAlign.center,
          fontSize: 14.sp,
          color: Colors.white,
          overflow: TextOverflow.ellipsis, // Avoid overflow
        ),
      ),
            // SizedBox(width: 1), // Add some spacing between the two widgets
      TextButton(
        onPressed: () {
          //TODO: Go to the chosen user or Shop owner
          navigateNamedTo(context, Routes.chosenStatusScreen);
        },
        child: myText(
          AText.regiserNewAccount.tr(context),
              color: ManagerColors.yellowColor, fontSize: 16,
        ),
      ),

    ],
  );
}

  Widget buildForgetPassButton(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        AText.forgetPass.tr(context),
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: ManagerColors.yellowColor),
      ),
    );
  }



  Widget buildBlocWidget(BuildContext context){
    return SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 30,right: 30,bottom: 30,top: 150.h),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // buildSpacer(10.0),
                Text(
                  AText.loginlbl.tr(context),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Colors.white),
                ),
                buildSpacerH(20.0),
                RoundedInputField(
                  hintText: AText.loginlbl.tr(context),
                  validator: (value) {
                    return ManagerValidator.validateEmail(value);
                  },
                ),
                buildSpacerH(20.0),
                RoundedInputField(
                  hintText: AText.yourPassword.tr(context),
                  isSecure: true,
                  validator: (value) {
                    return ManagerValidator.validateEmail(value);
                  },
                ),
                buildSpacerH(11.0),
                buildForgetPassButton(context),
                RoundedButtonWgt(
                    title: AText.loginlbl.tr(context),
                    fontSize: 18,
                    onPressed: () {
                      //TODO:  make it Login Function ....
                      navigateNamedTo(context, Routes.bottomTabBarScreen);
                    }),
                buildRegisterNewAccount(
                  context,
                ),
                buildSpacerH(20.0),
                const DividerWithText(),
                buildSpacerH(20.0),
                buildListOfLoginButtons(context),
              ],
            ),
          ),
        ),
      );
  }

///MARK: Scaffold 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManagerColors.kCustomColor,
      body: buildBlocWidget(context)
    );
  }
}
