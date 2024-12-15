import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/UI/widgets/login_bloc_listener.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // final String tYPEUSER;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        TextButton(
          onPressed: () {
            //TODO: Go to the chosen user or Shop owner
            navigateAndFinishNamed(context, Routes.chosenStatusScreen);
          },
          child: myText(
            AText.regiserNewAccount.tr(context),
            color: ManagerColors.yellowColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget buildForgetPassButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        navigateNamedTo(context, Routes.forgetPassword);
      },
      child: Text(
        AText.forgetPass.tr(context),
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: ManagerColors.yellowColor),
      ),
    );
  }

  Widget buildBlocWidget(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, bottom: 0,top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
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
                controller: context.read<LoginCubit>().emailController,
                hintText: AText.email.tr(context),
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,

                validator: (value) {
                  return ManagerValidator.validateEmail(value, context);
                },
              ),
              buildSpacerH(20.0),
              RoundedInputField(
                controller: context.read<LoginCubit>().passwordController,
                hintText: AText.yourPassword.tr(context),
                isSecure: true,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                
                validator: (value) {
                  return ManagerValidator.validatePassword(value, context);
                },
              ),
              buildSpacerH(11.0),
              buildForgetPassButton(context),
              RoundedButtonWgt(
                  title: AText.loginlbl.tr(context),
                  fontSize: 18,
                  onPressed: () {
                    validateThenDoSignIn(context);
                  }),
              buildRegisterNewAccount(
                context,
              ),
              buildSpacerH(20.0),
              // const DividerWithText(),
              // buildSpacerH(20.0),
        
              ///Login By Google
              //buildLoginByGoogle(),
              const LoginBlocListener()
        
              // buildListOfLoginButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  void validateThenDoSignIn(BuildContext context) {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      if (context.read<LoginCubit>().emailController.text ==
          "appacwdcom@gmail.com") {
        context.read<LoginCubit>().emitLogInOwnerApp(context);
      } else {
        context.read<LoginCubit>().emitLogIn(context);
      }
    }
  }

  ///MARK: Scaffold
  @override
  Widget build(BuildContext context) {
    // emailController.text = "adminOwner1000@gmail.com";
    // passwordController.text = "adminOwner1000@gmail.com";
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          backgroundColor: ManagerColors.kCustomColor,
          appBar: AppBar(
            backgroundColor: ManagerColors.kCustomColor,
            elevation: 0, // Make the AppBar blend with the background
            automaticallyImplyLeading: false, // Remove the default back button
            actions: [
              TextButton(
                onPressed: () {
                  // TODO: Add your "Skip" button logic here
                  // For example: navigate to the home screen
                  navigateAndFinishNamed(context, Routes.bottomTabBarScreen);
                },
                child: myText(AText.skip.tr(context),
                    color: ManagerColors.yellowColor, fontSize: 16),
              ),
            ],
          ),
          body: buildBlocWidget(context)),
    );
  }

  
}
