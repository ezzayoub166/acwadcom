import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/UI/screens/reset_password.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Headlines
            Text(AText.forgetPass.tr(context),
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: TSizes.spaceBtwItems),
            Text(AText.forgetPasswordSubTitle.tr(context),
                style: Theme.of(context).textTheme.labelMedium),
            SizedBox(height: TSizes.spaceBtwSections * 2),

            ///Text Fileds
            Form(
              key: context.read<LoginCubit>().forgetPasswordFormKey,
              child: RoundedInputField(
                hintText: "Email",
                controller: context.read<LoginCubit>().emailControllerForget,
                validator: (value) =>
                    ManagerValidator.validateEmail(value, context),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwSections),

            ///Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    // controller.sendPasswordResetEmail();
                    validateThenDoSendEmail(context);

                    // Get.off(() => ResetPassword(email: '',));
                  },
                  child: Text(AText.submit)),
            ),
            BlocListenerForgetPassword()
          ],
        ),
      ),
    );
  }

  void validateThenDoSendEmail(BuildContext context) {
    if (context
        .read<LoginCubit>()
        .forgetPasswordFormKey
        .currentState!
        .validate()) {
          context.read<LoginCubit>().sendPasswordResetEmail();
        }
  }
}

class BlocListenerForgetPassword extends StatelessWidget {
  const BlocListenerForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      state.whenOrNull(
          loading: () =>  TFullScreenLoader.openLoadingDialog('Processing your request....', LottieConstnts.loading_sing_up_animation,context),
          success: (){
            context.pop();
            ///!! Localiztion here ....
            TLoader.showSuccessSnackBar(context,title: 'Email Sent',message: 'Email Link sent to Reset Your Password'.tr(context));

            navigateNamedTo(context, Routes.resetPassword,context.read<LoginCubit>().emailControllerForget.text);
          },
          faluire:(error){
              TFullScreenLoader.stopLoading(context);
          TLoader.showErrorSnackBar(context,title: 'On Snap!',message: error.toString());
          } ,
      );
      
      },
      child: SizedBox.shrink(),
    );
  }
}
