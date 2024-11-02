// ignore_for_file: sort_child_properties_last

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_featured_code.dart';
import 'package:shimmer/shimmer.dart';

class CircleAvatarShimmerEffect extends StatelessWidget {
  const CircleAvatarShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
        ),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!);
  }
}

class RectangleShimmerEffect extends StatelessWidget {
  const RectangleShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
            decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        )),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!);
  }
}

class OfferShimmerItenEffect extends StatelessWidget {
  const OfferShimmerItenEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(15), // Adjust the radius as needed
            ),
            clipBehavior: Clip.antiAlias,
            // elevation: 5.0,
            child: SizedBox(height: 150, width: 150)),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!);
  }
}

class CouponShimmerEffect extends StatelessWidget {
  const CouponShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 4, // Number of shimmer items you want to show
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  // Shimmer for the image
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Shimmer for text and icons
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shimmer for the title
                        Container(
                          width: 150,
                          height: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        // Shimmer for the discount text
                        Container(
                          width: 100,
                          height: 12,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        // Shimmer for the number of times used
                        Container(
                          width: 80,
                          height: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Shimmer for the heart icon
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

