import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/common/widgets/build_custom_page_with_pagination.dart';
import 'package:acwadcom/features/admin/logic/home_admin_cubit/cubit/home_admin_cubit.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_alert_deatils_for_store.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_app_bar_for_admin.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_item_code_for_admin.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_shimmer_list_of_coupons.dart';
import 'package:acwadcom/features/user/coupons/ui/screens/coupon_deatls_screen.dart';
import 'package:acwadcom/models/coupon_model.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeAdminCubit>()
        ..emitCouponCount()
        ..emitGetCategories(),
      child: Scaffold(
        appBar: buildAppBarForAdmin(context, "All Coupons in App"),
        body: BlocBuilder<HomeAdminCubit, HomeAdminState>(
          buildWhen: (previous, current) =>
              current is SucessRemove || current is GetNumberOFCoubons,
          builder: (context, state) {
            return state.maybeWhen(
                getNumberOFCoubons: (number) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              myText("Number of coupons".tr(context),
                                  fontSize: 22,
                                  color: ManagerColors.kCustomColor,
                                  fontWeight: FontWeightEnum.Light.fontWeight),
                              myText(":", fontSize: 22),
                              myText("${number}",
                                  fontSize: 22,
                                  color: ManagerColors.yellowColor,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          buildSpacerH(10.0),
                          Expanded(
                              child: BuildCustomPageWithPagination(
                            pageSize: 4,
                            shrinkWrap: true,
                            query: FirebaseFirestore.instance
                                .collection('Coupons')
                                .withConverter(
                                  fromFirestore: (snapshot, _) =>
                                      Coupon.fromJson(snapshot.data()!),
                                  toFirestore: (coupon, _) =>
                                      (coupon as Coupon).toJson(),
                                ),
                            itemBuilder: (ctx, doc) {
                              var coupon =doc.data() as Coupon;
 // Ensure you have a fromJson factory method in Coupon
                              return GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return buildAlertDeatilsForStore(
                                            context, coupon);
                                      });
                                },
                                onTap: () {
                                  navigateTo(
                                      context,
                                      CouponDeatlsScreen(
                                        coupon: coupon,
                                      ));
                                },
                                child: BuildItmCodeForAdmin(
                                  coupon: coupon,
                                ),
                              );
                            },
                          ))
                        ],
                      ),
                    ),
                sucessRemove: () => Center(
                      child: Container(
                          color: ManagerColors.kCustomColor,
                          child: Text("Done")),
                    ),
                orElse: () => buildShimmerListOfCoupons());
          },
        ),
      ),
    );
  }
}
