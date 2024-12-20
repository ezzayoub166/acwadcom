  import 'dart:io';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/coupons/logic/cubit/create_coupon_cubit_cubit.dart';

Widget buildImagePicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "Download store logo".tr(context),
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "JPG or PNG or SVG\n(Max 128*128 pixels)".tr(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(width: 5),
        BlocBuilder<CreateCouponCubit, CreateCouponState>(
          buildWhen: (previous, current) =>
              current is LoadedSetLogoStore || current is LoadingSetLogoStore,
          builder: (context, state) {
            return state.maybeWhen(
                loadingSetLogoStore: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                loadedSetLogoStore: (imageURL) => CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(File(imageURL.path))),
                orElse: () => GestureDetector(
                    child: svgImage("_icAddImageFrame"),
                    onTap: () =>
                        context.read<CreateCouponCubit>().pickImage()));
          },
        )
      ],
    );
  }