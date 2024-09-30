

import 'package:acwadcom/acwadcom_packges.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, required this.selectStatus});

  final String selectStatus;

  Widget buildRegisterNewAccount(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);

            },
            child: Text(
              AText.loginlbl.tr(context),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: ManagerColors.yellowColor),
            )),
        Text(
          AText.haveAccount.tr(context),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget buildBlocWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 150.h),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // buildSpacer(10.0),
              Text(
                AText.creatNewAccountlbl.tr(context),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.white),
              ),
              buildSpacerH(20.0),
              RoundedInputField(
                hintText: AText.insertYourUserNamlbl.tr(context),
                validator: (value) {
                  return ManagerValidator.validateEmail(value);
                },
              ),
              buildSpacerH(20.0),
              RoundedInputField(
                hintText: AText.email.tr(context),
                validator: (value) {
                  return ManagerValidator.validateEmptyText(
                      AText.email, value ?? '');
                },
              ),
              buildSpacerH(20.0),
              RoundedInputField(
                hintText: AText.yourPassword.tr(context),
                isSecure: true,
                validator: (value) {
                  return ManagerValidator.validatePassword(value);
                },
              ),
              buildSpacerH(20.0),
              RoundedInputField(
                hintText: AText.confirmPassword.tr(context),
                isSecure: true,
                validator: (value) {
                  return ManagerValidator.validatePassword(value);
                },
              ),
              buildSpacerH(40.0),
              RoundedButtonWgt(
                  title: AText.creatNewAccountlbl.tr(context),
                  onPressed: () {
                    //TODO:  make it Login Function ....
                  }),
              buildRegisterNewAccount(
                context,
              ),
              const DividerWithText(),
              buildSpacerH(20.0),
              RoundedButtonWgt(
                backgroundColor: ManagerColors.myWhite,
                foregroundColor: Colors.black,
                title: "",
                onPressed: () {},
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AText.loginByApple.tr(context),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                    buildSpacerW(8),
                    svgImage(AImages.appleIconSvg,
                        height: 30.h, width: 30.w),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManagerColors.kCustomColor,
      body: buildBlocWidget(context)
    );
  }
}
