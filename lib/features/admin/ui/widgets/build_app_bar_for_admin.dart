  import 'package:acwadcom/acwadcom_packges.dart';

AppBar buildAppBarForAdmin(BuildContext context, String title) {
    return AppBar(
        backgroundColor: ManagerColors.kCustomColor,
        title: myText(
          title.tr(context),
          color: ManagerColors.myWhite,
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        actions:[ IconButton(onPressed: (){
          navigateAndFinishNamed(context, Routes.loginScreen);
        }, icon: const Icon(Iconsax.logout , color: Colors.white,))],
      );
  }