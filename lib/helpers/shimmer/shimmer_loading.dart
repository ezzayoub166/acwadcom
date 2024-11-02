import 'package:acwadcom/acwadcom_packges.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

class CouponShimerLoader extends StatelessWidget {
  const CouponShimerLoader({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Add padding for better spacing
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0), // Rounded corners for the card
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Light shadow for elevation effect
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Position of the shadow
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for the title
            Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10), // Spacer for vertical gap
            // Placeholder for a smaller subtitle
            Container(
              height: 16,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 20), // Spacer for larger vertical gap
            // Placeholder for a paragraph line
            Container(
              height: 12,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 8), // Small gap between lines
            // Second paragraph line
            Container(
              height: 12,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 8), // Small gap between lines
            // Third paragraph line
            Container(
              height: 12,
              width: 180,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


