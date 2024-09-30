import 'package:flutter/material.dart';



enum FontWeightEnum {
  Thin,
  ExtraLight,
  Light,
  Regular,
  Medium,
  SemiBold,
  Bold,
  ExtraBold,
}

extension FontWeightExtension on FontWeightEnum {
  FontWeight get fontWeight {
    switch (this) {
      case FontWeightEnum.Thin:
        return FontWeight.w100;
      case FontWeightEnum.ExtraLight:
        return FontWeight.w200;
      case FontWeightEnum.Light:
        return FontWeight.w300;
      case FontWeightEnum.Regular:
        return FontWeight.w400;
      case FontWeightEnum.Medium:
        return FontWeight.w500;
      case FontWeightEnum.SemiBold:
        return FontWeight.w600;
      case FontWeightEnum.Bold:
        return FontWeight.w700;
      case FontWeightEnum.ExtraBold:
        return FontWeight.w800;
    }
  }
}



  bool  isRTL(context){
      bool isRtl = Directionality.of(context) == TextDirection.rtl;
      return isRtl;
}



