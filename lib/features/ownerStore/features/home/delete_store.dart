import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/delete_store/cubit/delete_store_cubit.dart';
import 'package:acwadcom/features/user/authtication/data/authentication_repository.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';

class DeleteStore extends StatelessWidget {
  const DeleteStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithBackButton(context, isRTL(context)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            myText(
              "Are you sure you want to delete your store? All coupons for this store will also be deleted."
                  .tr(context),
              fontSize: 18,
              fontWeight: FontWeightEnum.ExtraBold.fontWeight,
            ),
            buildSpacerH(10),
            RoundedButtonWgt(
                title: AText.deleteStore.tr(context),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                height: 60,
                onPressed: () {
                  context.read<DeleteStoreCubit>().emitDeleteStore();
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
              child: SizedBox(height: 0,),
            )
          ],
        ),
      ),
    );
  }
}
