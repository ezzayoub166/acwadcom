// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/explore/logic/cubit/explore_cubit.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_coupon_clipper_widget.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_list_featured_stores.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:lottie/lottie.dart';

class ExplpreScreen extends StatefulWidget {
  const ExplpreScreen({super.key});

  @override
  State<ExplpreScreen> createState() => _ExplpreScreenState();
}

class _ExplpreScreenState extends State<ExplpreScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width * 0.8;

    return BlocProvider(
      create: (context) => getIt<ExploreCubit>()
        ..fetchMostUsedCoupons()
        ..fetchSpecialStores()
        ..fetchCouponsAddedRecently(),
      child: Scaffold(
          backgroundColor: Color(0xffF5F5F5),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: ListView(children: [
              isLoggedInUser
                  ? customAppBar(context)
                  : SizedBox(
                      height: 0,
                    ),
              buildSpacerH(10),
              ASearchContainer(
                text: AText.search.tr(context),
                onPressed: () => navigateNamedTo(context, Routes.searchScreen),
              ),
              buildSpacerH(10.0),
              TSectionHeader(
                title: AText.mostUsedCopuns.tr(context),
                textColor: ManagerColors.kCustomColor,
              ),
              //** The most used Copuns  */
              BlocBuilder<ExploreCubit, ExploreState>(
                buildWhen: (previous, current) =>
                    current is LoadingGetMostUsedCoupons ||
                    current is SuccessGetMostUsedCoupons ||
                    current is ErrorGetMostUsedCoupons,
                builder: (context, state) {
                  return state.maybeWhen(
                      loadingGetMostUsedCoupons: () => BuildCustomLoader(),
                      successGetMostUsedCoupons: (mostUsedCoupons) => SizedBox(
                            height: 200,
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: mostUsedCoupons.length,
                              separatorBuilder: (ctx, index) =>
                                  buildSpacerH(10.0),
                              itemBuilder: (context, index) {
                                //  bool isFav =  checkIfCouponsIsFav(coupons[index]);

                                return buildCouponClipperItem(
                                    context, mostUsedCoupons[index]);
                              },
                            ),
                          ),
                      errorGetMostUsedCoupons: (erro) =>
                          Center(child: myText(erro)),
                      orElse: () {
                        return SizedBox.shrink();
                      });
                },
              ),
              //** The Special Stores */
              buildSpacerH(10.0),
              TSectionHeader(
                  title: AText.featuredStore.tr(context),
                  textColor: ManagerColors.kCustomColor,
                  showActionButton: true,
                  onPressed: () =>
                      navigateNamedTo(context, Routes.listOfStoresScreen)),
              buildSpacerH(5.0),
              BlocBuilder<ExploreCubit, ExploreState>(
                buildWhen: (previous, current) =>
                    current is LoadingSpecialStores ||
                    current is SucessGetSpecialStores,
                builder: (context, state) {
                  return state.maybeWhen(
                      loadingSpecialStores: () => BuildCustomLoader(),
                      sucessGetSpecialStores: (stores) {
                        return BuildListFeaturedStores(
                          stores: stores,
                        );
                      },
                      orElse: () => BuildCustomLoader());
                },
              ),

              buildSpacerH(10.0),
              //** The Adddred Recntly */
              TSectionHeader(
                title: AText.recntlyAdded.tr(context),
                textColor: ManagerColors.kCustomColor,
                showActionButton: true,
              ),
              buildSpacerH(5.0),
              BlocBuilder<ExploreCubit, ExploreState>(
                buildWhen: (previous, current) =>
                    current is LoadingGetCoupons ||
                    current is SuccessGetCoupon ||
                    current is ErrorGetCoupons,
                builder: (context, state) {
                  return state.maybeWhen(
                      loadingGetCoupons: () => Center(
                            child: BuildCustomLoader(),
                          ),
                      successGetCoupon: (coupons) {
                        return BuildListMostUserCopuns(
                          itemWidth: itemWidth,
                          axis: Axis.vertical,
                          coupons: coupons,
                        );
                      },
                      errorGetCoupons: (error) => setUpError(error),
                      orElse: () {
                        return SizedBox.shrink();
                      });
                },
              ),
            ]),
          )),
    );
  }

  Widget setUpError(error) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            color: ManagerColors.blackTextColorexploreItem,
            borderRadius: BorderRadius.circular(10)),
        child: myText(error.toString(),
            fontSize: 16, fontWeight: FontWeightEnum.Bold.fontWeight),
      ),
    );
  }
}
