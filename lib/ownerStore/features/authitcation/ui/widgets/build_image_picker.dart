  import 'dart:io';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/ownerStore/features/authitcation/logic/register_owner/register_owner_store_cubit.dart';
import 'package:acwadcom/ownerStore/features/authitcation/logic/register_owner/register_owner_store_state.dart';

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
        BlocBuilder<RegisterOwnerStoreCubit, RegisterOwnerStoreState>(
          buildWhen: (previous, current) =>
              current is ImageStoreLoading || current is ImageStoreSelected,
          builder: (context, state) {
            return state.maybeWhen(
                loadingRegister: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                imageStoreSelected: (image) => CircleAvatar(
                  radius: 40,
                  backgroundImage: FileImage(File(image.path))
                ),
                orElse: () => GestureDetector(
                    child: svgImage("_icAddImageFrame"),
                    onTap: () =>
                        context.read<RegisterOwnerStoreCubit>().pickImage()));
          },
        )
      ],
    );
  }