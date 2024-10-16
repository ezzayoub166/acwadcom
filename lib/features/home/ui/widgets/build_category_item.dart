// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';

import 'package:acwadcom/models/category_model.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';

Widget buildCategoryItem(
    {required BuildContext context, required CategoryModel category}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
            backgroundColor:  category.isSelected ? ManagerColors.yellowColor.withOpacity(0.8) : ManagerColors.greyBackGroundCategore,
          child: CachedNetworkSVGImage(
            category.image,
            placeholder: const CircularProgressIndicator(color: ManagerColors.yellowColor),
            errorWidget: const Icon(Icons.error, color: Colors.red),
          ),
        ),
        buildSpacerH(4),
        Text(
          category.title.tr(context),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ManagerColors.textColor),
        ),
      ],
    ),
  );
}
