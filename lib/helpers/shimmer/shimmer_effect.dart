// ignore_for_file: sort_child_properties_last

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:shimmer/shimmer.dart';


class CircleAvatarShimmerEffect extends StatelessWidget {
  const CircleAvatarShimmerEffect(
      {super.key,});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
        ),
        baseColor:  Colors.grey[300]!,
        highlightColor: Colors.grey[100]!);
  }
}

class RectangleShimmerEffect extends StatelessWidget {
  const RectangleShimmerEffect(
      {super.key,});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child:  Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
              color: Colors.white,

          )
        ),
        baseColor:  Colors.grey[300]!,
        highlightColor:  Colors.grey[100]!);
  }
}

 class OfferShimmerItenEffect extends StatelessWidget {
  const OfferShimmerItenEffect({super.key});


  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                15), // Adjust the radius as needed
          ),
          clipBehavior: Clip.antiAlias,
          // elevation: 5.0,
          child: SizedBox(
               height: 150 , width: 150)
              
              ),
              baseColor:  Colors.grey[300]!,
        highlightColor: Colors.grey[100]!);
  }
}