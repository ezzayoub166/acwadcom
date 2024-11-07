

import 'package:acwadcom/acwadcom_packges.dart';

bool  isRTL(context){
      bool isRtl = Directionality.of(context) == TextDirection.rtl;
      return isRtl;
}

String calculateTimeRemaining(DateTime endDate) {
      final now = DateTime.now();
      final difference = endDate.difference(now);

      if (difference.isNegative) {
            return "Expired";
      } else {
            final days = difference.inDays;
            final hours = difference.inHours % 24;
            final minutes = difference.inMinutes % 60;

            if (days > 0) {
                  return '$days days, $hours hours, $minutes minutes';
            } else if (hours > 0) {
                  return '$hours hours, $minutes minutes';
            } else {
                  return '$minutes minutes';
            }
      }
}

