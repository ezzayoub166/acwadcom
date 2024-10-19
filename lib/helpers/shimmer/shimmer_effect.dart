// ignore_for_file: sort_child_properties_last

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/util/helper_functions.dart';
import 'package:shimmer/shimmer.dart';


class CircleAvatarShimmerEffect extends StatelessWidget {
  const CircleAvatarShimmerEffect(
      {super.key,});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
        child: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
        ),
        baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
        highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!);
  }
}

class RectangleShimmerEffect extends StatelessWidget {
  const RectangleShimmerEffect(
      {super.key,});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
        child:  Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
              color: Colors.white,

          )
        ),
        baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
        highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!);
  }
}