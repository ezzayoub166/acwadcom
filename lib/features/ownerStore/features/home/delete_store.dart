import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/delete_store/cubit/delete_store_cubit.dart';
import 'package:acwadcom/features/user/authtication/data/authentication_repository.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';

class DeleteStore extends StatelessWidget {
  final String text;

  DeleteStore({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: buildAppBarWithBackButton(context, isRTL(context)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            myText(
              text.tr(context),
              fontSize: 18,
              fontWeight: FontWeightEnum.ExtraBold.fontWeight,
            ),
            buildSpacerH(20.0),
            RoundedInputField(
              controller: emailController,
              hintText: AText.email.tr(context),
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                return ManagerValidator.validateEmail(value, context);
              },
            ),
            buildSpacerH(20.0),
            RoundedInputField(
              controller: passwordController,
              hintText: AText.yourPassword.tr(context),
              isSecure: true,
              textInputType: TextInputType.visiblePassword,
              validator: (value) {
                return ManagerValidator.validatePassword(value, context);
              },
            ),
            buildSpacerH(20),
            RoundedButtonWgt(
                title: AText.delete.tr(context),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                height: 60,
                onPressed: () {
                  context.read<DeleteStoreCubit>().emitDeleteStore(emailController.text , passwordController.text);
                }),
            BlocListener<DeleteStoreCubit, DeleteStoreState>(
              listenWhen: (previous, current) =>
                  current is LoadingRemoveStore ||
                  current is SuccessRemoveStore ||
                  current is FaluireRemoveStore,
              listener: (context, state) {
                state.whenOrNull(
                  loadingRemoveStore: () => BuildCustomLoader(),
                  successRemoveStore: () {
                    getIt<AuthenticationRepository>().logout(context);
                    navigateAndFinishNamed(context, Routes.loginScreen);
                  },
                  faluireRemoveStore: (error) {
                    TLoader.showErrorSnackBar(context, title: error);
                  },
                );
              },
              child: SizedBox(
                height: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
