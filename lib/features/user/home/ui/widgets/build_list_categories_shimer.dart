import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

class ListShimmerCategoires extends StatelessWidget {
  const ListShimmerCategoires({super.key});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          separatorBuilder: (context, index) => buildSpacerW(20),
          itemBuilder: (context, index) => const CircleAvatarShimmerEffect()));
    
  }
}
