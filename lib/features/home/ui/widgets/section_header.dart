import 'package:acwadcom/common/widgets/build_text_widget.dart';
import 'package:acwadcom/helpers/constants/colors.dart';
import 'package:acwadcom/helpers/util/extenstions.dart';
import 'package:flutter/material.dart';

class TSectionHeader extends StatelessWidget {
  const TSectionHeader({
    super.key,
    this.textColor ,
    this.showActionButton = false,
    required this.title,
    this.buttonTitle = "View all",
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
      children: [
        myText(
          title,
          fontSize: 16,
          fontWeight: FontWeightEnum.Regular.fontWeight,
          overflow: TextOverflow.ellipsis,
          maxLines: 1 ,
          color: ManagerColors.textColor,
             ),
     
        if(showActionButton) TextButton(onPressed: onPressed, child: Text(buttonTitle))
      ],
    );
  }
}
