 import 'package:acwadcom/acwadcom_packges.dart';

Flexible buildDashedLine() {
    return Flexible(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          12,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Container(
              color: const Color(0xffDCDCDC),
              height: 5,
              width: 2.w,
            ),
          ),
        ),
      ),
    );
  }