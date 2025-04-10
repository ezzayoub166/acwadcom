import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategoriesGrid extends StatelessWidget {
  const ShimmerCategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 items per row
          crossAxisSpacing: 16.0, // Spacing between columns
          mainAxisSpacing: 16.0, // Spacing between rows
        ),
        itemCount: 12, // Number of shimmer items
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                // Circle for the icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 8),
                // Placeholder for the text
                Container(
                  width: 50,
                  height: 10,
                  color: Colors.white,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
