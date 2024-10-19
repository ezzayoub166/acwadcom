import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/util/helper_functions.dart';
import 'package:flutter/cupertino.dart';

class ResetPassword extends StatelessWidget {
  final String email;
  const ResetPassword({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                context.pop();
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
                LottieConstnts.deliveredEmailIllustration,
                width: THelperFunctions.screenWidth(context) * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              ///Title & subtitle
              Text(AText.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                AText.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        // Get.offAll(() => LoginScreen());
                        navigateAndFinishNamed(context, Routes.chosenStatusScreen);
                      },
                      child: const Text("Done"))),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => context
                          .read<LoginCubit>()
                          .resendPasswordResetEmail(email),
                      child: const Text(AText.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}

class BlocListenerResetPassword extends StatelessWidget {
  const BlocListenerResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: () => TFullScreenLoader.openLoadingDialog(
              'Processing your request....',
              LottieConstnts.loading_sing_up_animation,
              context),
          success: () {
            TFullScreenLoader.stopLoading(context);
            TLoader.showSuccessSnackBar(
                title: 'Email Sent',
                message: 'Email Link sent to Reset Your Password',
                context);
          },
          faluire: (error) {
            TFullScreenLoader.stopLoading(context);
            TLoader.showErrorSnackBar(
                title: 'Oh snap!', message: error.toString(), context);
          },
        );
      },
      child: SizedBox.shrink(),
    );
  }
}
