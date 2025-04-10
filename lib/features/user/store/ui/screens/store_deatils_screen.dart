import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/explore/logic/cubit/explore_cubit.dart';
import 'package:acwadcom/features/user/home/ui/list_coupons_screen.dart';
import 'package:acwadcom/features/user/wishlist/data/wihslist_repository.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:lottie/lottie.dart';

import '../../../home/ui/widgets/build_list_coupons.dart';

class StoreDeatilsScreen extends StatefulWidget {
  final UserModel store;
  const StoreDeatilsScreen({super.key, required this.store});

  @override
  State<StoreDeatilsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDeatilsScreen> {
  bool isWishList = false;

  @override
  void initState() {
    super.initState();
    checkWishlistStatus();
  }

  Future<void> checkWishlistStatus() async {
    final wishlistStatus = await getIt<WihslistRepository>()
        .isWishListStore(widget.store.id);
    setState(() {
      isWishList = wishlistStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width * 0.9;

    return BlocProvider(
      create: (context) =>
          getIt<ExploreCubit>()..getCouponsForSelectedStore(widget.store.id),
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: ManagerColors.kCustomColor,
              expandedHeight: 200.h,
              pinned: true,
              leading: Padding(
                padding: EdgeInsets.only(
                  left: Localizations.localeOf(context).languageCode == 'ar'
                      ? 0
                      : 16,
                  right: Localizations.localeOf(context).languageCode == 'ar'
                      ? 16
                      : 0,
                ),
                child: InkWell(
                  child: svgImage(
                    "arrow-circle-left",
                    isRtl: isRTL(context),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () async {
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
                    child: svgImage(
                      isWishList ? "_icHeart_click" : "_icGrayHeart",
                      isRtl: isRTL(context),
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: ManagerColors.kCustomColor,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: ManagerColors.kCustomColor,
                        backgroundImage:
                            NetworkImage(widget.store.profilePicture),
                      ),
                      SizedBox(height: 10,),
                               myText(
                                 widget.store.userName,
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold,
                                 color: ManagerColors.whiteBtnBackGround,
                               )
                    ],
                  ),
                ),
              ),
            ),
  
            BlocBuilder<ExploreCubit, ExploreState>(
              buildWhen: (previous, current) =>
                  current is SuccessGetCoupon ||
                  current is LoadingGetCoupons ||
                  current is ErrorGetCoupons ||
                  current is EmptyListCoupons,
              builder: (context, state) {
                return state.maybeWhen(
                  loadingGetCoupons: () => SliverToBoxAdapter(
                    child:  BuildCustomLoader(),
                  ),
                  successGetCoupon: (coupons) => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BuildListMostUserCopuns(
                            itemWidth: itemWidth,
                            axis: Axis.vertical,
                            coupons: coupons,
                          ),
                        );
                      },
                      childCount: 1, // Adjust based on your layout
                    ),
                  ),
                  errorGetCoupons: (error) => SliverToBoxAdapter(
                    child: Center(
                      child: myText(error),
                    ),
                  ),
                  emptyListCoupons: () => SliverToBoxAdapter(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: LottieBuilder.asset(
                        "assets/animations/53207-empty-file.json",
                      ),
                    ),
                  ),
                  orElse: () => SliverToBoxAdapter(
                    child: Center(
                      child: myText("Not contain coupons yet.."),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
