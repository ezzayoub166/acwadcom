// import 'package:acwadcom/acwadcom_packges.dart';
// import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/app_localizations.dart';
import 'package:acwadcom/features/user/authtication/UI/screens/verify_email_screen.dart';
import 'package:acwadcom/features/user/coupons/logic/cubit/create_coupon_cubit_cubit.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../helpers/constants/lottie.dart';
import '../../../../../helpers/constants/strings.dart';
import '../../../../../helpers/loader/laoders.dart';
import '../../../../../helpers/popups/full_screen_loader.dart';
import '../../../../../helpers/util/extenstions.dart';

class CreateCouponListener extends StatelessWidget {
  const CreateCouponListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCouponCubit, CreateCouponState>(
      listenWhen: (previous, current) =>
          current is Loading ||
          current is Success ||
          current is Faluire ||
          current is NotSelectedLogoStore,
      listener: (context, state) {
        state.whenOrNull(loading: () {
          TFullScreenLoader.openLoadingDialog(
              "Loading Add Coubon..".tr(context),
              LottieConstnts.loading_sing_up_animation,
              context);
        }, faluire: (error) {
          context.pop();
          TLoader.showErrorSnackBar(context,
              title: AText.thresProblem.tr(context), message: error);
        }, notSelectedLogoStore: () {
          context.pop();
          showRequireImageSelectedDialog(context);
        }, success: () {
          context.pop();
          navigateTo(
              context,
              SuccessScreen(
                  image: LottieConstnts.loading_sing_up_animation,
                  title: AText.msgForReview.tr(context),
                  subTitle: "done opertion".tr(context),
                  altrnativeEmail:
                      "Once your code is approved, you will find it on the codes page."
                          .tr(context),
                  onPressed: () {
                    context.pop();
                    context.pop();
                  }));
        });
      },
      child: const SizedBox(),
    );
  }
}
