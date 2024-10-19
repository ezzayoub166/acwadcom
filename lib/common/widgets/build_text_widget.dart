import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget myText(final String text,
    {final double fontSize = 14,
      final FontWeight? fontWeight,
      final Color? color = ManagerColors.textColor,
      final TextAlign? textAlign,
      final int? maxLines,
      final String? fontFamaliy,
      final TextOverflow? overflow,
      final TextDecoration? textDecoration}) =>
    Text(text,
        maxLines: maxLines,
      overflow: overflow,
            textAlign: textAlign,
         style: GoogleFonts.cairo(
            fontSize: fontSize.sp,
            fontWeight: fontWeight,
            color: color,
            decoration: textDecoration));



            TextStyle TextStyleFont14({final double fontSize = 14,
      final FontWeight? fontWeight,
      final TextDecoration? textDecoration,
      final Color? color = ManagerColors.textColor}) {
        return GoogleFonts.cairo(
            fontSize: fontSize.sp,
            fontWeight: fontWeight,
            color: color,
            decoration: textDecoration);
      }
     