// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/authtication/data/authentication_repository.dart';
import 'package:acwadcom/features/home/logic/avatar/avatar_cubit.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Profile section
            buildAvatarStoreOwner(),
            Divider(),
            // Drawer items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: myText(AText.home.tr(context)),
                    onTap: () {
                      // Handle Home navigation
                      pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.bar_chart),
                    title: myText("Statistics".tr(context)),
                    onTap: () {
                      // Handle Statistics navigation
                      navigateNamedTo(context, Routes.statisticsPage);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.add),
                    title: myText(AText.createDiscountCode.tr(context)),
                    onTap: () {
                      // Handle Add Discount Code navigation
                      navigateNamedTo(context, Routes.createCodeForUserScreen);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: myText(AText.notification.tr(context)),
                    onTap: () {
                      // Handle Notifications navigation
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: myText(AText.storeData.tr(context)),
                    onTap: () {
                      // Handle Store Info navigation
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.card_giftcard),
                    title: Text(AText.changeLanguage.tr(context)),
                    onTap: () {
                      // Handle Your Codes navigation
                      navigateNamedTo(context, Routes.languageSelectionPage);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: myText(AText.deleteStore.tr(context),
                        color: Colors.red),
                    onTap: () {
                      // Handle Delete Store action
                    },
                  ),
                  ListTile(
                    leading: Icon(Iconsax.logout,color: Colors.black,),
                    title: myText(AText.logOut.tr(context),
                        ),
                    onTap: () {
                      // Handle Delete Store action
                      getIt<AuthenticationRepository>().logout();
                      navigateAndFinishNamed(context, Routes.chosenStatusScreen);

                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder<dynamic, dynamic> buildAvatarStoreOwner() {
        var username = getIt<CacheHelper>().getValueWithKey("USERNAME") ?? "";

    return BlocBuilder<AvatarCubit, AvatarState>(
          buildWhen: (previous, current) => current is FetchNameImage,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
             CircleAvatar(
              radius: 30,
              backgroundImage: state.imageUrl == ""
                  ? AssetImage("assets/images/user.png")
                  : CachedNetworkImageProvider(state.imageUrl)),
              SizedBox(height: 12),
              Text(
                state.username,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              // Text(
              //   'متجر فوقا',
              //   style: TextStyle(
              //     fontSize: 14,
              //     color: Colors.grey,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
