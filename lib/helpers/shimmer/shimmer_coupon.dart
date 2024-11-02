import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CouponCardShimmer extends StatelessWidget {
  const CouponCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for logo and store name
            Container(
              width: 30,
              height: 30,
              color: Colors.grey, // Placeholder for store logo
            ),
            const SizedBox(width: 8),
            Container(
              width: 100,
              height: 12,
              color: Colors.grey, // Placeholder for store name
            ),
            const SizedBox(height: 8),
            // Placeholder for discount code
            Container(
              width: 80,
              height: 12,
              color: Colors.grey, // Placeholder for discount code
            ),
            const SizedBox(height: 8),
            // Placeholder for description
            Container(
              width: 150,
              height: 12,
              color: Colors.grey, // Placeholder for description
            ),
            const SizedBox(height: 8),
            // Placeholder for end date
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  color: Colors.grey, // Placeholder for date icon
                ),
                const SizedBox(width: 4),
                Container(
                  width: 80,
                  height: 12,
                  color: Colors.grey, // Placeholder for end date text
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
