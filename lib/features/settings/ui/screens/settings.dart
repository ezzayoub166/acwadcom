// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/app_localizations.dart';
import 'package:acwadcom/common/widgets/build_spacer_height.dart';
import 'package:acwadcom/cubit/locale_cubit.dart';
import 'package:acwadcom/helpers/Routing/routes.dart';
import 'package:acwadcom/helpers/constants/colors.dart';
import 'package:acwadcom/helpers/constants/sizes.dart';
import 'package:acwadcom/helpers/constants/strings.dart';
import 'package:acwadcom/helpers/util/extenstions.dart';
import 'package:acwadcom/helpers/widgets/common/svgImageWgt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ListView(
          children: [
            buildAvatarProfile(context),
            buildSpacerH(10.0),
            ListTile(
              title: Text(AText.settings.tr(context),
                  style: TextStyle(fontSize: 18)),
            ),
            buildNotifcationSwitch(context),
            buildSpacerH(10.0),
            buildChangeLangauge(context),
            buildSpacerH(10.0),
            buildGoToAccount(context),
            buildSpacerH(10.0),
            ListTile(
              title:
                  Text(AText.other.tr(context), style: TextStyle(fontSize: 18)),
            ),
            buildHelpCenterWgt(context),
            buildSpacerH(10.0),
            buildTermsCondWgt(context),
            Divider(),
            // buildYouStoreOwnerWgt(context),
          ],
        ),
      ),
    );
  }

  ListTile buildYouStoreOwnerWgt(BuildContext context) {
    return ListTile(
            title: Text(AText.areYouOwner.tr(context),
                style: TextStyle(fontSize: 18)),
            subtitle: Text(AText.becomeAartner.tr(context),
                style: TextStyle(color: Colors.orange)),
            leading: Icon(Icons.store, color: Colors.orange),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
             
              // Navigate to merchant section
            },
          );
  }

  Container buildTermsCondWgt(BuildContext context) {
    return Container(
            decoration: buildDecorationProfile(),
            child: ListTile(
              title: Text(AText.termsConditions.tr(context),
                  style: TextStyle(fontSize: 18)),
              leading: svgImage("_icSimcard"),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                // Navigate to terms and conditions
              },
            ),
          );
  }

  Container buildHelpCenterWgt(BuildContext context) {
    return Container(
            decoration: buildDecorationProfile(),
            child: ListTile(
              title: Text(AText.helpCenter.tr(context),
                  style: TextStyle(fontSize: 18)),
              leading: svgImage("_icCenterHelp"),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                // Navigate to help center
                 navigateNamedTo(context, Routes.contactUs);
              },
            ),
          );
  }

  Container buildGoToAccount(BuildContext context) {
    return Container(
            decoration: buildDecorationProfile(),
            child: ListTile(
              title: Text(AText.account.tr(context),
                  style: TextStyle(fontSize: 18)),
              leading: svgImage("_icprofile"),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                // Navigate to account settings
                navigateNamedTo(context, Routes.profileScreen);
              },
            ),
          );
  }

  Container buildChangeLangauge(BuildContext context) {
    return Container(
            decoration: buildDecorationProfile(),
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    AText.language.tr(context),
                    style: TextStyle(fontSize: 18),
                  ),
                  BlocBuilder<LocaleCubit, ChangeLocaleState>(
                    builder: (context, state) {
                      return Text(" (${state.locale.languageCode})",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: ManagerColors.yellowColor));
                    },
                  ),
                ],
              ),
              leading: svgImage("language-circle"),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                // Navigate to language settings
                navigateNamedTo(context, Routes.languageSelectionPage);
              },
            ),
          );
  }

  Container buildNotifcationSwitch(BuildContext context) {
    return Container(
            decoration: buildDecorationProfile(),
            child: SwitchListTile(
              title: Text(AText.notification.tr(context),
                  style: TextStyle(fontSize: 18)),
              secondary: svgImage("_icSettingsNotification"),
              value: true, // Set initial value here
              onChanged: (value) {
                // Handle switch change
              },
            ),
          );
  }

  Container buildAvatarProfile(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      height: 100.h,
      decoration: buildDecorationProfile(),
      child: Row(
        children: [
          CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("assets/images/tow.jpeg")),
          buildSpacerW(10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Use spaceBetween for spacing
              children: [
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the start
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      "Izzdine Atallah",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: ManagerColors.kCustomColor),
                    ),
                    Text(
                      "Joined a month ago",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: ManagerColors.textColorDark),
                    ),
                  ],
                ),
                buildSpacerW(5),
                IconButton(icon: Icon(Iconsax.edit), onPressed: () {
                     // Navigate to account settings
                navigateNamedTo(context, Routes.profileScreen,true);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildDecorationProfile() {
    return BoxDecoration(
        color: ManagerColors.greyLighColor,
        borderRadius: BorderRadius.circular(10));
  }
}
