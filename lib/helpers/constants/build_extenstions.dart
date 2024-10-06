

import 'package:acwadcom/acwadcom_packges.dart';

bool  isRTL(context){
      bool isRtl = Directionality.of(context) == TextDirection.rtl;
      return isRtl;
}