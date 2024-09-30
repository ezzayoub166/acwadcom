
// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/common/widgets/build_spacer_height.dart';
import 'package:acwadcom/features/home/ui/widgets/home_categories.dart';
import 'package:acwadcom/helpers/constants/colors.dart';
import 'package:acwadcom/helpers/widgets/common/svgImageWgt.dart';
import 'package:flutter/material.dart';

Widget buildCategoryItem({ required BuildContext context , required CategoryModel category}){
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: ManagerColors.greyBackGroundCategore ,
              child: svgImage(category.image),
            ),
            buildSpacerH(4),
            Text(category.title,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ManagerColors.textColor),),
          ],
        ),
      );
    }