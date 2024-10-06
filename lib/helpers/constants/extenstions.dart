import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

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




bool isLoggedInUser = false;
bool isOpenApp = false;




