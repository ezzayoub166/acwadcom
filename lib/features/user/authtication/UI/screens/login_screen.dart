import 'dart:async';
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/UI/widgets/login_bloc_listener.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // final String tYPEUSER;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isConnectedToInternt = false;

  StreamSubscription? _intrenetConnectionStreamSubscription;
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
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  controller: context.read<LoginCubit>().emailController,
                  hintText: AText.email.tr(context),
                  textInputType: TextInputType.emailAddress,
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
                const DividerWithText(),
                buildSpacerH(20.0),

                ///Login By Google
                RoundedButtonWgt(
                  backgroundColor: ManagerColors.myWhite,
                  foregroundColor: Colors.black,
                  title: "",
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: EdgeInsets.all(24),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Icon at the top
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child:
                                      svgImage("icBuildLogo", fit: BoxFit.fill),
                                ),
                                SizedBox(height: 16),

                                // Confirmation Text
                                Column(
                                  children: [
                                    myText(
                                      "sign in as ?",
                                          // .tr(context),
                                      textAlign: TextAlign.center,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),

                                // Buttons: Cancel and Delete
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ManagerColors.yellowColor,
                                          foregroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        onPressed: () async{
                                          //sign in as user action here ...
                                          tYPEUSER = "USER";
                                          print(tYPEUSER);
                                          context.pop();
                                           await context.read<LoginCubit>().emitLogInByGoogle(context);


                                        },
                                        child: Text(AText.user
                                            .tr(context)), //loclaiztion
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12),
                                          side: BorderSide(color: Colors.black),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        onPressed: () async{
                                          // Handle sing as store action here..
                                            tYPEUSER = "STOREOWNER";
                                            context.pop();
                                            print(tYPEUSER);
                                           await context.read<LoginCubit>().emitLogInByGoogle(context);
                                     
                                        },
                                        child: myText(
                                            AText.shopOwner.tr(context),
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                   
                  },
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AText.loginByGoogle.tr(context),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      svgImage("google_brand_branding_logo_network_icon",
                          height: 24.h, width: 24.w),
                    ],
                  ),
                ),
                const LoginBlocListener()

                // buildListOfLoginButtons(context),
              ],
            ),
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
