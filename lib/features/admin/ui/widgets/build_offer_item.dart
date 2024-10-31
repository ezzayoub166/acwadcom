import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/models/offer_model.dart';

class BuildOfferItem extends StatelessWidget {
  const BuildOfferItem({
    super.key,
    required this.offer,
  });

  final OfferModel offer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onDoubleTap: () => launchURL(context,offer.offerUrl),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  15), // Adjust the radius as needed
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 5.0,
            child: extendedImageWgt(offer.imageUrl,
                150, 140, BoxFit.cover)),
      ),
    );
  }
}