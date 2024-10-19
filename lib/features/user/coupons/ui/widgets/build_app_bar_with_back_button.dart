  import 'package:acwadcom/acwadcom_packges.dart';

AppBar buildAppBarWithBackButton(BuildContext context, bool isRtl , {String title = ""}) {
    return AppBar(
      centerTitle: true,
      title :  myText(
            title,
            // color: ManagerColors.kCustomColor,
            fontSize: 20,
          ),
        leading: Padding(
          padding: EdgeInsets.only(
            left: Localizations.localeOf(context).languageCode == 'ar'
                ? 0
                : 16, // Padding for English
            right: Localizations.localeOf(context).languageCode == 'ar'
                ? 16
                : 0, // Padding for Arabic
          ),
          child: InkWell(
            child: svgImage("Vector", isRtl: isRtl),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        leadingWidth: 50,
        automaticallyImplyLeading: true,
      );
  }