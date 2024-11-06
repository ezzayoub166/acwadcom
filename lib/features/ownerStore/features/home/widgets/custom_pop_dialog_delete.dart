// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/admin/logic/home_admin_cubit/cubit/home_admin_cubit.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/coupon_model.dart';

Widget buildAlertDelete(
    {required BuildContext context, required Coupon coupon}) {
  return AlertDialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    contentPadding: EdgeInsets.all(24),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon at the top
        Container(
          width: 100,
          height: 100,
          child: svgImage("icDeleteIcom", fit: BoxFit.fill),
        ),
        SizedBox(height: 16),

        // Confirmation Text
        Column(
          children: [
            myText(
              "Are you sure you delete the code?".tr(context),
              textAlign: TextAlign.center,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            myText(
              coupon.title,
              textAlign: TextAlign.center,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ],
        ),
        SizedBox(height: 24),

        // Buttons: Cancel and Delete
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ManagerColors.yellowColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AText.cancel.tr(context)),
              ),
            ),
            SizedBox(width: 12),
            BlocProvider(
              create: (context) => getIt<HomeAdminCubit>(),
              child: Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Handle delete action here
                    

                    context.read<HomeAdminCubit>()
                        .emitRemoveCoupon(coupon.couponId);
                    Navigator.of(context).pop();
                  },
                  child: myText(AText.delete.tr(context), color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
