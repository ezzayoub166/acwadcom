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
                                return GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return AlertDialog(
                                            backgroundColor:
                                                ManagerColors.kCustomColor,
                                            content: Container(
                                                height: 250,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      myImage(
                                                          "icon_app_acwdcom",
                                                          height: 140,
                                                          width: 150),
                                                      Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          myText(
                                                              AText.phoneNumber.tr(context),
                                                              fontSize: 18,
                                                              color: ManagerColors
                                                                  .yellowColor
                                                          ),
                                                          buildSpacerW(5.0),
                                                          myText(
                                                                fontSize: 12,
                                                                color: ManagerColors
                                                                    .whiteBtnBackGround,
                                                            "${coupons[index].ownerCoupon.phoneNumber}",
                                                          ),
                                                          IconButton
                                                            (
                                                            color: ManagerColors.yellowColor,
                                                            icon: Icon(Icons.copy , ),
                                                            onPressed: () {
                                                                                   //** copy the phone Number  for Coupon....... */
                                                              copyTextToClipboard(coupons[index].ownerCoupon.phoneNumber, context);
                                         

                                                            },
                                                          )
                                                        ],
                                                      ),
                                                      buildSpacerH(10.0),
                                                      // Coupon Owner
                                                      Row(
                                                        children: [
                                                          myText(
                                                              AText.storeName.tr(context),
                                                              fontSize: 18,
                                                              color: ManagerColors
                                                                  .yellowColor),
                                                                                                                            buildSpacerW(5.0),

                                                          myText(
                                                            fontSize: 12,
                                                            color: ManagerColors
                                                                .whiteBtnBackGround,
                                                            "${coupons[index].ownerCoupon.userName}",
                                                          )
                                                        ],
                                                      ),



                                                    ],
                                                  ),
                                                )),
                                          );
                                        });
                                  },
                                  child: BuildItmCodeForAdmin(
                                    coupon: coupons[index],
                                  ),
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
