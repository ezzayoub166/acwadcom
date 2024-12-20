import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_page_with_pagination.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_alert_deatils_for_store.dart';
import 'package:acwadcom/features/user/coupons/ui/screens/coupon_deatls_screen.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_featured_code.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_list_coupons.dart';
import 'package:acwadcom/helpers/shimmer/shimmer_loading.dart';
import 'package:acwadcom/models/coupon_model.dart';

class ListCouponsScreen extends StatefulWidget {
  const ListCouponsScreen({super.key});

  @override
  State<ListCouponsScreen> createState() => _ListCouponsScreenState();
}

class _ListCouponsScreenState extends State<ListCouponsScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    Timestamp currentTimestamp = Timestamp.fromDate(currentDate);
    return Scaffold(
      appBar: AppBar(
        title: myText(AText.discoverOffers.tr(context)),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: BuildCustomPageWithPagination(
            pageSize: 3,
            shrinkWrap: true,
            query: FirebaseFirestore.instance.collection('Coupons')
              .where('EndDate', isGreaterThan: currentTimestamp).withConverter<Coupon>(
                fromFirestore: (snapshot, _) {
                  final data = snapshot.data();
                  if (data == null) {
                    throw StateError("Null data found for document ID: ${snapshot.id}");
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
}
/*
BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              current is SuccessFeatchedCoupons ||
              current is LoadingCoupons,
          builder: (context, state) {
            return state.maybeWhen(
                loadingCoupons: () => const buildLoaderShimmerList(),
                successFeatchedCoupons: (coupons) =>
                    Expanded(child: BuildListCoupons(coupons: coupons , isScroll: true,)),
                errorFeatchedCoupons: (error) => Container(
                      color: Colors.red,
                      child: Text(error.toString()),
                    ),
                orElse: () {
                  return const buildLoaderShimmerList();
                });
          },
        ),
*/

class buildLoaderShimmerList extends StatelessWidget {
  const buildLoaderShimmerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            return const CouponShimerLoader();
          },
          separatorBuilder: (ctx, index) => buildSpacerH(10.0),
          itemCount: 5),
    );
  }
}
