
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/admin/logic/home_admin_cubit/cubit/home_admin_cubit.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_app_bar_for_admin.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_item_code_for_admin.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    // List<Coupon> yourCoupons = [];
    //

    return BlocProvider(
      create: (context) => getIt<HomeAdminCubit>()..emitGetCoupons(),
      child: Scaffold(
        appBar: buildAppBarForAdmin(context, "All Coupons in App".tr(context)),
        body: BlocBuilder<HomeAdminCubit, HomeAdminState>(
          buildWhen: (previous, current) =>
              current is SuccessGetCoupons ||
              current is LoadingCoupons ||
              current is SucessRemove ||
              current is GetNumberOFCoubons,
          builder: (context, state) {
            return state.maybeWhen(
                loadingCoupons: () => BuildCustomLoader(),
                successGetCoupons: (coupons) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              myText("Number of coupons".tr(context),
                                  fontSize: 22,
                                  color: ManagerColors.kCustomColor,
                                  fontWeight: FontWeightEnum.Light.fontWeight),
                              myText(":", fontSize: 22),
                              myText("${coupons.length}",
                                  fontSize: 22,
                                  color: ManagerColors.yellowColor,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          buildSpacerH(10.0),
                          ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return BuildItmCodeForAdmin(
                                  coupon: coupons[index],
                                );
                              },
                              separatorBuilder: (ctx, index) =>
                                  buildSpacerH(10.0),
                              itemCount: coupons.length)
                        ],
                      ),
                    ),
                sucessRemove: () => Center(
                      child: Container(
                          color: ManagerColors.kCustomColor,
                          child: Text("Done")),
                    ),
                orElse: () => const SizedBox());
          },
        ),
      ),
    );
  }
}
