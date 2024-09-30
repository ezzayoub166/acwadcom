import 'package:acwadcom/app_localizations.dart';
import 'package:acwadcom/common/widgets/build_spacer_height.dart';
import 'package:acwadcom/cubit/locale_cubit.dart';
import 'package:acwadcom/helpers/constants/strings.dart';
import 'package:acwadcom/helpers/widgets/common/svgImageWgt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSize customAppBar(BuildContext context) {
  return PreferredSize(
      preferredSize: Size.fromHeight(70.h),
      child: AppBar(
        backgroundColor: Colors.transparent, // AppBar background color
        // toolbarHeight:10,
        surfaceTintColor: Colors.transparent,
        toolbarOpacity:0,
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
                    const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("assets/images/tow.jpeg")),
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
                        Text("Mohmed Almy".tr(context),
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
                    BlocProvider.of<LocaleCubit>(context).changeLanguage("en");
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
