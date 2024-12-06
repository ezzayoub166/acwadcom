import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_list_coupons.dart';
import 'package:acwadcom/helpers/shimmer/shimmer_loading.dart';

class ListCouponsScreen extends StatefulWidget {
  const ListCouponsScreen({super.key});

  @override
  State<ListCouponsScreen> createState() => _ListCouponsScreenState();
}

class _ListCouponsScreenState extends State<ListCouponsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: myText(AText.discoverOffers.tr(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  current is SuccessFeatchedCoupons ||
                  current is LoadingCoupons,
              builder: (context, state) {
                return state.maybeWhen(
                    loadingCoupons: () => const buildLoaderShimmerList(),
                    successFeatchedCoupons: (coupons) =>
                        Expanded(child: BuildListCoupons(coupons: coupons)),
                    errorFeatchedCoupons: (error) => Container(
                          color: Colors.red,
                          child: Text(error.toString()),
                        ),
                    orElse: () {
                      return const buildLoaderShimmerList();
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}

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
