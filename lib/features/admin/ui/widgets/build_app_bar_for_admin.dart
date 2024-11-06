  import 'package:acwadcom/acwadcom_packges.dart';

AppBar buildAppBarForAdmin(BuildContext context, String title) {
    return AppBar(
      leading: IconButton(icon: Icon(Iconsax.translate),onPressed: () {
            navigateNamedTo(context, Routes.languageSelectionPage);

        
      },),
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