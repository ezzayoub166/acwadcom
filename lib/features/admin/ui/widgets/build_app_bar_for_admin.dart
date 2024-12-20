  import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/data/authentication_repository.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';

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
          getIt<AuthenticationRepository>().logout(context);
        }, icon: const Icon(Iconsax.logout , color: Colors.white,))],
      );
  }