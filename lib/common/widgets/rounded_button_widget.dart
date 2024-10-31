import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButtonWgt extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget? icon;
  final double height;
  final double width;
  final double raduis ;
  final bool isBorder ;  
  final Color borderColor;
  final double fontSize;

  const RoundedButtonWgt({super.key, required this.title, required this.onPressed,  this.backgroundColor = ManagerColors.yellowColor,  this.foregroundColor = Colors.white, this.icon, this.height = 60, this.width = double.infinity, this.raduis = 30.0, this.isBorder = false,this.borderColor = Colors.black,  this.fontSize = 16
});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width ,
        child: ElevatedButton(

          onPressed: onPressed ,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
          side: isBorder ? BorderSide(color: foregroundColor, width: 2) : BorderSide.none, // Border color and width
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(raduis),
          ),
          ),
          child: icon ?? myText(
            fontSize: fontSize.sp,
            title,
            color: foregroundColor),
            
          ),
      );
  }
}