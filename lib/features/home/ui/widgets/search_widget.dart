import 'package:acwadcom/app_localizations.dart';
import 'package:acwadcom/common/widgets/build_spacer_height.dart';
import 'package:acwadcom/features/home/ui/widgets/build_filter_bottom_sheet.dart';
import 'package:acwadcom/helpers/constants/colors.dart';
import 'package:acwadcom/helpers/constants/sizes.dart';
import 'package:acwadcom/helpers/constants/strings.dart';
import 'package:acwadcom/helpers/widgets/common/svgImageWgt.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ASearchContainer extends StatelessWidget {
  const ASearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onPressed,
    // this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onPressed;
  // final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ///Filter

        Expanded(
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              // width: TDeviceUtils.getScreenWidth(context) / 1/ ,
              padding: const EdgeInsets.all(TSizes.md),
              decoration: BoxDecoration(
                color: ManagerColors.greyLighColor,
                borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                border: showBorder ? Border.all(color: Colors.black12) : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: ManagerColors.greyColor,
                  ),
                  buildSpacerW(TSizes.spaceBtwItems),
                  Text(
                    AText.search.tr(context),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
          ),
        ),

        buildSpacerW(10),

        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) {
                return BuildFilterBottomSheet();
              },
            );
          },
          child: CircleAvatar(
            backgroundColor: ManagerColors.kCustomColor,
            radius: 30,
            child: svgImage("_icsetting"),
          ),
        ),
      ],
    );
  }
}
