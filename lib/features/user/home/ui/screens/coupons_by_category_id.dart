import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_page_with_pagination.dart';
import 'package:acwadcom/features/user/coupons/ui/screens/coupon_deatls_screen.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_featured_code.dart';
import 'package:acwadcom/models/coupon_model.dart';

class CouponsByCategoryIdScreen extends StatefulWidget {
  const CouponsByCategoryIdScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  State<CouponsByCategoryIdScreen> createState() => _CouponsByCategoryIdState();
}

class _CouponsByCategoryIdState extends State<CouponsByCategoryIdScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var locale = getIt<CacheHelper>().getChacedLanguageCode();
    DateTime currentDate = DateTime.now();
    Timestamp currentTimestamp = Timestamp.fromDate(currentDate);
    return Scaffold(
      appBar: AppBar(
        title: myText(locale == "en"
            ? widget.category.title["en"]
            : widget.category.title["ar"]),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: BuildCustomPageWithPagination(
            pageSize: 3,
            shrinkWrap: true,
            emptyBuilder: buildEmptylistForSelectedById(screenHeight, screenWidth, context),
            query: FirebaseFirestore.instance
                .collection('Coupons')
                .where('EndDate', isGreaterThan: currentTimestamp)
                .where("CategoryID", isEqualTo: widget.category.categoryId)
                .withConverter<Coupon>(
                  fromFirestore: (snapshot, _) {
                    final data = snapshot.data();
                    if (data == null) {
                      throw StateError(
                          "Null data found for document ID: ${snapshot.id}");
                    }
                    return Coupon.fromJson(data);
                  },
                  toFirestore: (coupon, _) => coupon.toJson(),
                ),
            itemBuilder: (ctx, doc) {
              final coupon = doc.data();

              return GestureDetector(
                onTap: () {
                  navigateTo(
                      context,
                      CouponDeatlsScreen(
                        coupon: coupon,
                      ));
                },
                child: BuildFeaturedCode(
                  coupon: coupon,
                ),
              );
            },
          )),
    );
  }

  Center buildEmptylistForSelectedById(double screenHeight, double screenWidth, BuildContext context) {
    return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container for the icon/image
                Padding(
                  padding: EdgeInsets.only(
                      bottom: screenHeight * 0.01), // Adjusted spacing
                  child: svgImage(
                    "_icEmpty",
                    size: screenWidth *
                        0.4, // Slightly reduced size for better layout
                    height: screenWidth * 0.4,
                  ),
                ),
                // Text with improved styling and spacing
                myText(
                  "There are no coupons for this category".tr(context),
                  textAlign: TextAlign.center,
                  fontSize: screenWidth *
                      0.045, // Slightly smaller for proportionality
                  fontWeight: FontWeight.w500,
                  color:
                      Colors.grey[700], // Softer color for better aesthetics
                ),
              ],
            ),
          );
  }
}
