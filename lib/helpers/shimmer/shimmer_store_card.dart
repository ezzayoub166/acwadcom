import 'package:acwadcom/common/widgets/build_spacer_height.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoreCardShimmer extends StatelessWidget {
  const StoreCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
         height: 160,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          separatorBuilder: (ctx, index) => buildSpacerW(10.0),
          itemBuilder: (context, index) {
    return Container(
      height: 120,
      width: 130, // Fixed width to match your design
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAlias,
              elevation: 5.0,
              child: Container(
                width: 140,
                height: 100,
                color: Colors.grey, // Placeholder for the image
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 15,
                    color: Colors.grey, // Placeholder for the store name
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    width: 100,
                    height: 12,
                    color: Colors.grey, // Placeholder for the store details
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );}
    ));
  }
}
