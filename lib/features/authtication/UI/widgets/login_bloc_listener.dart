import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/authtication/data/authentication_repository.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';


class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: (){
            TFullScreenLoader.openLoadingDialog(AText.loggingIn.tr(context), LottieConstnts.loading_sing_up_animation, context);
          },faluire: (error){
           TFullScreenLoader.stopLoading(context);
          TLoader.showErrorSnackBar(context,title: 'On Snap!',message: error.toString());

            // setupErrorState(context, error);
          },success: () {
            TFullScreenLoader.stopLoading(context);
             getIt<AuthenticationRepository>().screenRedirect(context);
            // navigateAndFinishNamed(context, Routes.bottomTabBarScreen);
          },
          successForOwner: () {
            TFullScreenLoader.stopLoading(context);
            navigateAndFinishNamed(context, Routes.tabBarAdmin);

          },
        );
      },
      child: SizedBox.shrink(),
    );
  }
}

  void setupErrorState(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: myText(
          error,
          color: ManagerColors.kCustomColor,
          fontSize: 15
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: myText(
              'Got it',
              fontSize: 14,
              fontWeight: FontWeight.bold,

            ),
          ),
        ],
      ),
    );
  }
