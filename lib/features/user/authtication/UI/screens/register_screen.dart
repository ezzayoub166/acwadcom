import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/custom_phone_number_filed.dart';
import 'package:acwadcom/features/user/authtication/UI/widgets/build_terms_and_condtions.dart';
import 'package:acwadcom/features/user/authtication/logic/register/cubit/register_cubit.dart';
import 'package:acwadcom/features/user/settings/ui/screens/terms_condions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/loader/laoders.dart';
import 'package:acwadcom/helpers/popups/animation_loader.dart';
import 'package:flutter/gestures.dart';

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
              navigateAndFinishNamed(context, Routes.loginScreen);
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
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                            ),
                            TAnimationLoaderWidget(
                                text: "We are processing your information..."
                                    .tr(context),
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
                      'Your account has been created! Verify email to continue'
                          .tr(context));

              //Move to Verity Email Screen
              navigateNamedTo(context, Routes.verifyEmailScreen, "USER");
              // Get.to(() => VerifyEmailScreen(email: userCredential.user?.email));
            },
            registerGoogleSuccess: () {
              //Show Success Message
              Navigator.pop(context);
              TLoader.showSuccessSnackBar(context,
                  title: 'Congratulation',
                  message: 'Your account has been created!'.tr(context));

              //Move to Verity Email Screen
              navigateNamedTo(context, Routes.bottomTabBarScreen, "USER");
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
                      textInputAction: TextInputAction.next,
                      
                      validator: (value) {
                        return ManagerValidator.validateEmptyText(
                            "username", value ?? "",context);
                      },
                    ),
                    buildSpacerH(20.0),
                    //** Phone Number */
                    CustomPhoneNumberInput(
                      controller: context.read<RegisterCubit>().phoneController,
                      selectorTextStyle:  GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,),
                    ),
                    //  buildSpacerH(20.0),

                    // RoundedInputField(
                    //   controller: context.read<RegisterCubit>().phoneController,
                    //   hintText: AText.phoneNumber.tr(context).tr(context),
                    //   textInputType: TextInputType.number,
                    //   validator: (value) {
                    //     return ManagerValidator.validatePhoneNumber(value,
                    //         context: context);
                    //   },
                    // ),
                    buildSpacerH(20.0),
                    //** Email */
                    RoundedInputField(
                      controller: context.read<RegisterCubit>().emailController,
                      hintText: AText.email.tr(context),
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        return ManagerValidator.validateEmptyText(
                            AText.email, value ?? '',context);
                      },
                    ),
                    buildSpacerH(20.0),
                    //** Password */
                    RoundedInputField(
                      controller:
                          context.read<RegisterCubit>().passwordController,
                      hintText: AText.yourPassword.tr(context),
                      isSecure: true,
                       textInputAction: TextInputAction.next,
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
                      textInputAction: TextInputAction.done,
                      isSecure: true,
                      validator: (value) {
                        return ManagerValidator.validatePassword(
                            value, context);
                      },
                    ),
                    buildSpacerH(20.0),
                    buildTermsAndCondtions(),
                    buildSpacerH(20.0),
                    RoundedButtonWgt(
                        title: AText.creatNewAccountlbl.tr(context),
                        onPressed: () {
                          ///** Validate then signup */
                          validateThenDoSignup(context);
                        }),
                    buildRegisterNewAccount(
                      context,
                    ),
                    // const DividerWithText(),
                    buildSpacerH(20.0)
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
          backgroundColor: ManagerColors.kCustomColor,
          body: buildBlocWidget(context)),
    );
  }

  void validateThenDoSignup(BuildContext context) {
    if (context.read<RegisterCubit>().formKey.currentState!.validate() &&
        context.read<RegisterCubit>().passwordController.text ==
            context.read<RegisterCubit>().passwordConfirmationController.text) {
      // Save the form to trigger onSaved methods
      context.read<RegisterCubit>().formKey.currentState!.save();
      context.read<RegisterCubit>().emitRegisterStates();
      getIt<CacheHelper>().removeValueWithKey("tYPEUSER");
      getIt<CacheHelper>().saveValueWithKey("tYPEUSER", "USER");
    }
  }
}


