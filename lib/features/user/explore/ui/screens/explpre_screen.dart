// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/coupons/ui/screens/coupon_deatls_screen.dart';
import 'package:acwadcom/features/user/explore/logic/cubit/explore_cubit.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_coupon_clipper_widget.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_list_featured_stores.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/shimmer/shimmer_loading.dart';
import 'package:acwadcom/helpers/shimmer/shimmer_store_card.dart';
import 'package:acwadcom/models/coupon_model.dart';

class ExplpreScreen extends StatefulWidget {
  const ExplpreScreen({super.key});

  @override
  State<ExplpreScreen> createState() => _ExplpreScreenState();
}

class _ExplpreScreenState extends State<ExplpreScreen> {
  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width * 0.8;

    return BlocProvider(
      create: (context) => getIt<ExploreCubit>()
        ..fetchMostUsedCoupons()
        ..fetchSpecialStores()
        ..fetchCouponsAddedRecently(5),
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
              buildSpacerH(10.0),
              //** The most used Copuns  */
              BlocBuilder<ExploreCubit, ExploreState>(
                buildWhen: (previous, current) =>
                    current is LoadingGetMostUsedCoupons ||
                    current is SuccessGetMostUsedCoupons ||
                    current is ErrorGetMostUsedCoupons,
                builder: (context, state) {
                  return state.maybeWhen(
                      loadingGetMostUsedCoupons: () =>
                         shimmerLoadingCoupons(),
                      successGetMostUsedCoupons: (mostUsedCoupons) => buildListMostUsedCoupons(mostUsedCoupons),
                      errorGetMostUsedCoupons: (erro) =>
                          Center(child: myText(erro)),
                      orElse: () =>
                          shimmerLoadingCoupons());
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
                    current is SucessGetSpecialStores ||
                    current is FaluireGetStores,
                builder: (context, state) {
                  return state.maybeWhen(
                      loadingSpecialStores: () => StoreCardShimmer(),
                      sucessGetSpecialStores: (stores) {
                        return BuildListFeaturedStores(
                          stores: stores,
                        );
                      },
                      faluireGetStores: (error) {
                        if (mounted) {
                          TLoader.showErrorSnackBar(context, title: error);
                        }
                        return SizedBox.shrink();
                      },
                      orElse: () => StoreCardShimmer());
                },
              ),

              buildSpacerH(10.0),
              //** The Adddred Recntly */
              TSectionHeader(
                title: AText.recntlyAdded.tr(context),
                textColor: ManagerColors.kCustomColor,
                showActionButton: true,
                onPressed: ()=>navigateNamedTo(context,Routes.listRecentlyAddedCouponsScreen),
              ),
              buildSpacerH(5.0),
              BlocBuilder<ExploreCubit, ExploreState>(
                buildWhen: (previous, current) =>
                    current is LoadingGetCoupons ||
                    current is SuccessGetCoupon ||
                    current is ErrorGetCoupons,
                builder: (context, state) {
                  return state.maybeWhen(
                      loadingGetCoupons: () => shimmerLoadingCoupons(),
                      successGetCoupon: (coupons) {
                        return BuildListMostUserCopuns(
                          itemWidth: itemWidth,
                          axis: Axis.vertical,
                          coupons: coupons,
                        );
                      },
                      errorGetCoupons: (error) => setUpError(error),
                      orElse: () {
                        return shimmerLoadingCoupons();
                      });
                },
              ),
            ]),
          )),
    );
  }

  SizedBox shimmerLoadingCoupons() => SizedBox(height: 150, child: const CouponShimerLoader());

  SizedBox buildListMostUsedCoupons(List<Coupon> mostUsedCoupons) {
    return SizedBox(
                          height: 120,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: mostUsedCoupons.length,
                            separatorBuilder: (ctx, index) =>
                                buildSpacerW(10.0),
                            itemBuilder: (context, index) {

                              return GestureDetector(
                                onTap: () {
                                  navigateTo(
                                      context,
                                      CouponDeatlsScreen(
                                          coupon: mostUsedCoupons[index]));
                                },
                                child: buildCouponClipperItem(
                                    context, mostUsedCoupons[index]),
                              );
                            },
                          ),
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
