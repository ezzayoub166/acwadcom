  import 'package:acwadcom/acwadcom_packges.dart';

AppBar buildAppBarWithBackButton(BuildContext context, bool isRtl , {String title = "", VoidCallback? onPressedBack} ) {
    return AppBar(
      centerTitle: true,
      title :  myText(
            title,
            fontWeight: FontWeightEnum.ExtraBold.fontWeight,
            color: ManagerColors.kCustomColor,
            fontSize: 16,
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
            onTap: onPressedBack ?? () {
              Navigator.pop(context);
            },
            child: svgImage("Vector", isRtl: isRtl),
          ),
        ),
        leadingWidth: 50,
        automaticallyImplyLeading: true,
      );
  }