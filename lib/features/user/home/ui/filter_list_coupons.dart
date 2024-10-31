import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/home/logic/filter/cubit/filter_coupons_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_list_coupons.dart';
import 'package:lottie/lottie.dart';

class FilterListCoupons extends StatefulWidget {
  final String categoryID;
  final int rate;

  const FilterListCoupons(
      {super.key, required this.categoryID, required this.rate});

  @override
  State<FilterListCoupons> createState() => _FilterListCouponsState();
}

class _FilterListCouponsState extends State<FilterListCoupons> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<FilterCouponsCubit>().emitFilterCoupons(widget.categoryID, widget.rate);

  }

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
            BlocBuilder<FilterCouponsCubit, FilterCouponsState>(
              buildWhen: (previous, current) =>
                  current is LoadingFilterCoupons ||
                  current is SuccessGetFilterCoupons ||
                  current is FaluireGetFilterCoupons ||
                  current is EemptyFilterCoupons,
              builder: (context, state) {
                 return state.maybeWhen(
                    loadingGetFilterCoupons: () =>
                        Center(child: BuildCustomLoader()),
                    successGetFilterCoupons: (coupons) =>
                        BuildListCoupons(coupons: coupons),
                    faluireGetFilterCoupons: (error) => Container(
                          color: Colors.red,
                          child: Text(error),
                        ),
                    emptyFilterCoupons: () => SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: LottieBuilder.asset(
                              "assets/animations/53207-empty-file.json"),
                        ),
                    orElse: () {
                      return const SizedBox();
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
