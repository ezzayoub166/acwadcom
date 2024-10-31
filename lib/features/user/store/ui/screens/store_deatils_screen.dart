import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/explore/logic/cubit/explore_cubit.dart';
import 'package:acwadcom/features/user/wishlist/data/wihslist_repository.dart';
import 'package:acwadcom/features/user/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:lottie/lottie.dart';

import '../../../home/ui/widgets/build_list_coupons.dart';

class StoreDeatilsScreen extends StatefulWidget {
  final UserModel store;
  const StoreDeatilsScreen({super.key, required this.store});

  @override
  State<StoreDeatilsScreen> createState() => _StoreDeatilsScreenState();
}

class _StoreDeatilsScreenState extends State<StoreDeatilsScreen> {
  bool isWishList = false;
  @override
  void initState() {
    // TODO: implement InitState
    super.initState();
    checkWishlistStatus();
  }

  // Create an async method to handle the async operation
  Future<void> checkWishlistStatus() async {
    isWishList =
        await getIt<WihslistRepository>().isWishListStore(widget.store.id);
    setState(() {
      // Trigger UI update once the async call is done
    });
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width * 0.9;

    return BlocProvider(
      create: (context) =>
          getIt<ExploreCubit>()..getCouponsForSelectedStore(widget.store.id),
      child: Scaffold(
          backgroundColor: Color(0xffF5F5F5),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: ManagerColors.kCustomColor,
                  height: 200.h,
                  width: double.infinity,
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    backgroundColor: ManagerColors.kCustomColor,
                    leading: Padding(
                      padding: EdgeInsets.only(
                        left:
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? 0
                                : 16, // Padding for English
                        right:
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? 16
                                : 0, // Padding for Arabic
                      ),
                      child: InkWell(
                        child: svgImage("arrow-circle-left",
                            isRtl: isRTL(context)),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    actions: [
                      BlocBuilder<WishlistStoresCubit, WishListStoresState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 16, // Padding for English
                                right: 16 // Padding for Arabic
                                ),
                            child: InkWell(
                              child: isWishList
                                  ? svgImage("_icHeart_click",
                                      isRtl: isRTL(context))
                                  : svgImage("_icGrayHeart",
                                      isRtl: isRTL(context)),
                              onTap: () async {
                                //** TOTO heart Store.... */
                                // Navigator.pop(context);
                                // Handle adding/removing from wishlist on tap
                                if (isWishList) {
                                  await getIt<WihslistRepository>()
                                      .removeStoreFromWishList(widget.store);
                                } else {
                                  await getIt<WihslistRepository>()
                                      .addStoreToWishList(widget.store);
                                }

                                setState(() {
                                  isWishList = !isWishList;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  )),
              Positioned.fill(
                  left: 10,
                  right: 10,
                  top: 130.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 60.r,
                          backgroundColor: ManagerColors.kCustomColor,
                          backgroundImage:
                              NetworkImage(widget.store.profilePicture)),
                      myText(widget.store.userName,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ManagerColors.kCustomColor),
                      BlocBuilder<ExploreCubit, ExploreState>(
                        buildWhen: (previous, current) =>
                            current is SuccessGetCoupon ||
                            current is LoadingGetCoupons ||
                            current is ErrorGetCoupons ||
                            current is EmptyListCoupons,
                        builder: (context, state) {
                          return state.maybeWhen(
                            loadingGetCoupons: () => BuildCustomLoader(),
                            successGetCoupon: (coupons) =>
                                BuildListMostUserCopuns(
                              itemWidth: itemWidth,
                              axis: Axis.vertical,
                              coupons: coupons,
                            ),
                            errorGetCoupons: (error) =>
                                Center(child: myText(error)),
                            emptyListCoupons: () => SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: LottieBuilder.asset("assets/animations/53207-empty-file.json"),
                            ),
                            orElse: () => Center(
                                child: myText("not contain Coupons yet..")),
                          );
                        },
                      )

                      // BuildListMostUserCopuns(itemWidth: itemWidth , axis: Axis.vertical,isExpanded: true,)
                    ],
                  ))
            ],
          )),
    );
  }
}
