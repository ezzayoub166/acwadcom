
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
Widget svgImage(
    icon, {
      Color? color,
      double? size,
      double? height,
      double? width,
      BoxFit fit= BoxFit.contain,
      bool isRtl = false,
      ColorFilter? color_filter,
    }) =>
    Transform(
    
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(isRtl ? 3.14 : 0),
      child: SvgPicture.asset(
      
        'assets/images/$icon.svg',
        
        height: height,
        width:width?? size,
        fit: fit,
        colorFilter: color_filter,
      
      ),
    );

Widget myImage(
    icon, {
      Color? color,
      double? size,
      double? width,
      BoxFit fit= BoxFit.contain, double? height
    }) =>
    Image.asset(
      'assets/images/$icon.png',
      color: color,
      height: height,
      width:width?? size,
      fit: fit,


    );