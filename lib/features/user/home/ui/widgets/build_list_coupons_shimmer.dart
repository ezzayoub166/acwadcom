import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

class ListShimmerCoupons extends  StatelessWidget {
  const ListShimmerCoupons({super.key});


  @override
  Widget build(BuildContext context) {
     return SizedBox(
       child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                return RectangleShimmerEffect();
                },
              separatorBuilder: (ctx, index) => buildSpacerH(10.0),
              itemCount: 10),
     );
    
  }
}
