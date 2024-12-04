// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/app_localizations.dart';
import 'package:acwadcom/common/widgets/build_spacer_height.dart';
import 'package:acwadcom/features/ownerStore/features/home/widgets/custom_pop_dialog_require_login.dart';
import 'package:acwadcom/features/user/settings/ui/screens/terms_condions.dart';
import 'package:acwadcom/localiztion_cubit/locale_cubit.dart';
import 'package:acwadcom/features/user/home/logic/avatar/avatar_cubit.dart';
import 'package:acwadcom/helpers/Routing/routes.dart';
import 'package:acwadcom/helpers/constants/colors.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/constants/sizes.dart';
import 'package:acwadcom/helpers/constants/strings.dart';
import 'package:acwadcom/helpers/util/extenstions.dart';
import 'package:acwadcom/helpers/widgets/common/svgImageWgt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var uSERNAME = "";
  var iMAGEURL = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // uSERNAME = getIt<CacheHelper>().getValueWithKey("USERNAME") ?? "";
    // iMAGEURL = getIt<CacheHelper>().getValueWithKey("IMAGEURL") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace,
          vertical: isLoggedInUser ? TSizes.defaultSpace : 5,
        ),
        child: ListView(
          children: [
            isLoggedInUser
                ? BlocBuilder<AvatarCubit, AvatarState>(
                    builder: (context, state) {
                      return buildAvatarProfile(
                          context, state.username, state.imageUrl);
                    },
                    buildWhen: (previous, current) => current is FetchNameImage,
                  )
                : SizedBox(height: 1),
            isLoggedInUser ?  buildSpacerH(10.0) : SizedBox(),
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
            buildDeleteAccount(context),
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
      title:
          Text(AText.areYouOwner.tr(context), style: TextStyle(fontSize: 18)),
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
          navigateTo(context,TermsAndConditionsScreen());
        },
      ),
    );
  }

  Container buildHelpCenterWgt(BuildContext context) {
    return Container(
      decoration: buildDecorationProfile(),
      child: ListTile(
        title:
            Text(AText.helpCenter.tr(context), style: TextStyle(fontSize: 18)),
        leading: svgImage("_icCenterHelp"),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
        onTap: () {
          // Navigate to help center
          navigateNamedTo(context, Routes.contactUs);
        },
      ),
    );
  }
    void showRequireLoginDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmRequireLoginDialog();
      },
    );
  }

  Container buildGoToAccount(BuildContext context) {
    return Container(
      decoration: buildDecorationProfile(),
      child: ListTile(
        title: Text(AText.account.tr(context), style: TextStyle(fontSize: 18)),
        leading: svgImage("_icprofile"),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
        onTap: () {
          // Navigate to account settings
             if (isLoggedInUser) {
          navigateNamedTo(context, Routes.profileScreen);
              } else {
                showRequireLoginDialog(context);
              }
        },
      ),
    );
  }

  Container buildDeleteAccount(BuildContext context){

    return Container(
      decoration: buildDecorationProfile(),
      child: ListTile(
        title: Text(AText.deleteAccount.tr(context), style: TextStyle(fontSize: 18)),
        leading: Icon(Icons.delete,color : Colors.red),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
        onTap: () {
          // Navigate to account settings
             if (isLoggedInUser) {
              navigateNamedTo(context, Routes.deleteStoreScreen, "Are you sure you want to delete your account? All coupons for this account will also be deleted.");
              } else {
                showRequireLoginDialog(context);
              }
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
          showRequireLoginDialog(context);
          // Handle switch change
        },
      ),
    );
  }

  Container buildAvatarProfile(
      BuildContext context, String userName, String profileImage) {
    return Container(
      padding: EdgeInsets.all(4),
      height: 100.h,
      decoration: buildDecorationProfile(),
      child: Row(
        children: [
          CircleAvatar(
              radius: 40,
              backgroundImage: profileImage == ""
                  ? AssetImage("assets/images/user.png")
                  : CachedNetworkImageProvider(profileImage)),
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
                      userName,
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
                IconButton(
                    icon: Icon(Iconsax.edit),
                    onPressed: () {
                      // Navigate to account settings
                      navigateNamedTo(context, Routes.editProfileScreen, true);
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
