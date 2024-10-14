import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/app_localizations.dart';
import 'package:acwadcom/common/widgets/build_spacer_height.dart';
import 'package:acwadcom/localiztion_cubit/locale_cubit.dart';
import 'package:acwadcom/features/home/logic/avatar/avatar_cubit.dart';
import 'package:acwadcom/helpers/constants/strings.dart';
import 'package:acwadcom/helpers/widgets/common/svgImageWgt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BlocBuilder<dynamic, dynamic> customAppBar(BuildContext context) {
  return BlocBuilder<AvatarCubit, AvatarState>(
    buildWhen: (previous, current) => current is FetchNameImage,
    builder: (context, state) {
      return PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          backgroundColor: Colors.transparent, // AppBar background color
          // toolbarHeight:10,
          surfaceTintColor: Colors.transparent,
          toolbarOpacity: 0,
          elevation: 0, // Remove AppBar shadow
          automaticallyImplyLeading: false, // Remove default back button
          flexibleSpace: Container(
            // padding: const EdgeInsets.only(top: 15),
            // margin: EdgeInsets.only(bottom:10 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                   CircleAvatar(
              radius: 30,
              backgroundImage: state.imageUrl == ""
                  ? AssetImage("assets/images/user.png")
                  : CachedNetworkImageProvider(state.imageUrl)),
                    buildSpacerW(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AText.welcom.tr(context),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.black38)),
                        buildSpacerH(4),
                        Text(state.username,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black)),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  child: svgImage("notification_light", height: 24, width: 24),
                  onTap: () {
                    //TODO / go to list notifcations ...
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
