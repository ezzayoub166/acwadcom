
// import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/authtication/UI/screens/verify_email_screen.dart';
import 'package:acwadcom/features/coupons/logic/cubit/create_coupon_cubit_cubit.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/constants/lottie.dart';
import '../../../../helpers/loader/laoders.dart';
import '../../../../helpers/popups/full_screen_loader.dart';
import '../../../../helpers/util/extenstions.dart';

class CreateCouponListener extends StatelessWidget {
  const CreateCouponListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCouponCubit, CreateCouponState>(
      listenWhen: (previous, current) => current is Loading || current is Success || current is Faluire,
      listener: (context, state) {
        state.whenOrNull(
          loading:(){
            TFullScreenLoader.openLoadingDialog("Loading Add Coubon..", LottieConstnts.loading_sing_up_animation, context);
          } ,
          faluire: (error){
            context.pop();
            TLoader.showErrorSnackBar(context, title: "Error",message: error);
          },
          success: (){
            context.pop();
            navigateTo(context,Center(
              child: SuccessScreen(image: LottieConstnts.loading_sing_up_animation, title: "Success Added Code", subTitle: "done opertion", onPressed: (){
               context.pop();
              context.pop();
              }),
            ));
          }
        );
      },
      child: const SizedBox(),
    );
  }
}
