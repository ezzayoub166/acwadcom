import 'dart:async';
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/data/authentication_repository.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/util/helper_functions.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lottie/lottie.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String typeUser;

  const VerifyEmailScreen({super.key, required this.typeUser});

  // final String? email;

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _authRepository = getIt<AuthenticationRepository>();

  sendEmailVerification() async {
    try {
      // Use the Auth Repository to send the verification email
      await _authRepository.sendEmailVerification();
      if (mounted) {
        TLoader.showSuccessSnackBar(
          context,
          title: "Email sent".tr(context),
          message: 'Please check your inbox and verify your email'.tr(context),
        );
      }
    } catch (e) {
      if (mounted) {
        TLoader.showErrorSnackBar(
          context,
          title: 'Oh Snap!',
          message: e.toString(),
        );
      }
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();

        ///Get.off() : this destroy the previous screen (mean the verification)
        if (mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SuccessScreen(
                  image: "assets/images/sammy-line-man-receives-a-mail.png",
                  title: AText.yourAccountCreatedTitle,
                  subTitle: AText.yourAccountCreatedSubTitle,
                  onPressed: () => _authRepository.screenRedirect(context))));
        }
      }
    });
  }

  ///Manually check if Email Verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await currentUser.reload(); // Reload the user data
      final updatedUser =
          FirebaseAuth.instance.currentUser; // Get the updated user data

      if (kDebugMode) {
        print(updatedUser?.email);
      }
      if (kDebugMode) {
        print(updatedUser?.emailVerified);
      }

      if (updatedUser!.emailVerified) {
        if (kDebugMode) {
          print("Email is verified");
        }
        getIt<CacheHelper>().saveValueWithKey("userID", updatedUser.uid);
        if (mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SuccessScreen(
                  image: "assets/images/check_user_verifiction.json",
                  title: AText.yourAccountCreatedTitle.tr(context),
                  subTitle: AText.yourAccountCreatedSubTitle.tr(context),
                  onPressed: () => _authRepository.screenRedirect(context))));
        }
      } else {
        TLoader.showWarningSnackBar(context, title: "Email is not verified".tr(context));
        if (kDebugMode) {
          print("Email is not verified");
        }
      }
    } else {
      if (kDebugMode) {
        print("No current user");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the method to send the email verification on initialization if needed
    sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(EmailVerificationCubit(getIt<AuthenticationRepository>()));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: ()  {
                _authRepository.logout(context);
                navigateAndFinishNamed(context, Routes.loginScreen);
              },
              icon: Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image.asset(
                "assets/images/sammy-line-man-receives-a-mail.png",
                width: THelperFunctions.screenWidth(context) * 0.6,
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              ///Title & subtitle
              Text("confirm Email".tr(context),
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              SizedBox(height: TSizes.spaceBtwItems),
              // Text(
              //   // widget.email ?? '',
              //   style: Theme.of(context).textTheme.labelLarge,
              //   textAlign: TextAlign.center,
              // ),
              SizedBox(height: TSizes.spaceBtwItems),
              Text(
                AText.confirmEmailSubTitle.tr(context),
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              ///Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        checkEmailVerificationStatus();
                      },
                      child: Text(AText.next.tr(context)))),
              SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => sendEmailVerification(),
                      child: Text("Send to Email".tr(context)))),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  final String image, title, subTitle ;
  final String?  altrnativeEmail;

  final VoidCallback onPressed;

  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed,   this.altrnativeEmail });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight * 1.2,
            child: Column(
              children: [
                ///Image
                Lottie.asset(
                  image,
                  width: THelperFunctions.screenWidth(context) * 0.6,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
          
                ///Title & subtitle
                myText(title,
                    color: Color(0xFFD3D3D3),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    maxLines: 3,
                    textAlign: TextAlign.center),
                SizedBox(height: TSizes.spaceBtwItems),
                myText(
                  altrnativeEmail ?? "appacwdcom@gmail.com" ,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                myText(
                  subTitle,
                  fontSize: 14,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: TSizes.spaceBtwSections),
          
                //Button
          
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: onPressed, child: Text(AText.next.tr(context))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
      top: TSizes.appBarHeight,
      left: TSizes.defaultSpace,
      right: TSizes.defaultSpace,
      bottom: TSizes.defaultSpace);
}
