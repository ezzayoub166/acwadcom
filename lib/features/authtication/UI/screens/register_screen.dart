import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/authtication/UI/screens/verify_email_screen.dart';
import 'package:acwadcom/features/authtication/logic/register/cubit/register_cubit.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/loader/laoders.dart';
import 'package:acwadcom/helpers/popups/animation_loader.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, required this.selectStatus});

  final String selectStatus;

  static void openLoadingDialog(String text, String animation) {}

  Widget buildRegisterNewAccount(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AText.haveAccount.tr(context),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigator.pop(context);
            },
            child: Text(
              AText.loginlbl.tr(context),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: ManagerColors.yellowColor),
            )),
      ],
    );
  }

  Widget buildBlocWidget(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        // TODO: implement listener
        state.when(
            initial: () {},
            registerLoading: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => PopScope(
                      canPop: false,
                      child: Container(
                        color: ManagerColors.dark,
                        width: double.infinity,
                        height: double.infinity,
                        child: const Column(
                          children: [
                            SizedBox(
                              height: 250,
                            ),
                            TAnimationLoaderWidget(
                                text: 'We are processing your information...',
                                animation: "assets/images/loading_sign.json")
                          ],
                        ),
                      )));
            },
            registerSuccess: () {
              //Show Success Message
              Navigator.pop(context);
              TLoader.showSuccessSnackBar(context,
                  title: 'Congratulation',
                  message:
                      'Your account has been created! Verify email to continue');

              //Move to Verity Email Screen
              navigateNamedTo(context, Routes.verifyEmailScreen,UserType.normalUser);
              // Get.to(() => VerifyEmailScreen(email: userCredential.user?.email));
            },
            registerError: (error) {
              Navigator.pop(context);

              TLoader.showErrorSnackBar(context,
                  title: 'On Snap!', message: error.toString());
            });
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 150.h),
              child: Form(
                key: context.read<RegisterCubit>().formKey,
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

                    //** Full Name */
                    RoundedInputField(
                      controller: context.read<RegisterCubit>().nameController,
                      hintText: AText.insertYourUserNamlbl.tr(context),
                      validator: (value) {
                        return ManagerValidator.validateEmptyText(
                            AText.userNamelbl.tr(context), value ?? "");
                      },
                    ),
                    buildSpacerH(20.0),
                    //** Phone Number */
                    RoundedInputField(
                      controller: context.read<RegisterCubit>().phoneController,
                      hintText: AText.phoneNumber.tr(context).tr(context),
                      validator: (value) {
                        return ManagerValidator.validatePhoneNumber(value,
                            context: context);
                      },
                    ),
                    buildSpacerH(20.0),
                    //** Email */
                    RoundedInputField(
                      controller: context.read<RegisterCubit>().emailController,
                      hintText: AText.email.tr(context),
                      validator: (value) {
                        return ManagerValidator.validateEmptyText(
                            AText.email, value ?? '');
                      },
                    ),
                    buildSpacerH(20.0),
                    //** Password */
                    RoundedInputField(
                      controller:
                          context.read<RegisterCubit>().passwordController,
                      hintText: AText.yourPassword.tr(context),
                      isSecure: true,
                      validator: (value) {
                        return ManagerValidator.validatePassword(
                            value, context);
                      },
                    ),
                    buildSpacerH(20.0),
                    //** Confirm Password */
                    RoundedInputField(
                      controller: context
                          .read<RegisterCubit>()
                          .passwordConfirmationController,
                      hintText: AText.confirmPassword.tr(context),
                      isSecure: true,
                      validator: (value) {
                        return ManagerValidator.validatePassword(
                            value, context);
                      },
                    ),
                    buildSpacerH(40.0),
                    RoundedButtonWgt(
                        title: AText.creatNewAccountlbl.tr(context),
                        onPressed: () {
                          ///** Validate then signup */
                          validateThenDoSignup(context);
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
                          // SvgPicture.asset(
                          //   "assets/images/google_brand_branding_logo_network_icon.svg"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ManagerColors.kCustomColor,
        body: buildBlocWidget(context));
  }

  void validateThenDoSignup(BuildContext context) {
    if (context.read<RegisterCubit>().formKey.currentState!.validate() &&
        context.read<RegisterCubit>().passwordController.text ==
            context.read<RegisterCubit>().passwordConfirmationController.text) {
      context.read<RegisterCubit>().emitRegisterStates();
      getIt<CacheHelper>().removeValueWithKey("tYPEUSER");
       getIt<CacheHelper>().saveValueWithKey("tYPEUSER" , "USER");
    }
  }
}
