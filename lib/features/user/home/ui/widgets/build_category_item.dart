// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/util/language_cache_helper.dart';
import 'package:acwadcom/localiztion_cubit/locale_cubit.dart';

import 'package:acwadcom/models/category_model.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';

Widget buildCategoryItem(
    {required BuildContext context, required CategoryModel category , required int selectedIndex , required int itemIndex}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
            backgroundColor:  itemIndex == selectedIndex ? ManagerColors.yellowColor.withOpacity(0.8) : ManagerColors.greyBackGroundCategore,
          child: CachedNetworkSVGImage(
            category.image,
            placeholder: const CircularProgressIndicator(color: ManagerColors.yellowColor),
            errorWidget: const Icon(Icons.error, color: Colors.red),
          ),
        ),
        buildSpacerH(4),
         BlocBuilder<LocaleCubit, ChangeLocaleState>(
          builder: (context, state) {
            String currentLanguage = state.locale.languageCode;
            return Text(
              currentLanguage == "en" ? category.title["en"] : category.title["ar"],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ManagerColors.textColor),
            );
          },
        ),
      ],
    ),
  );
}
