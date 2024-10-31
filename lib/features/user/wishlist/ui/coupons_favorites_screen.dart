import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/wishlist/logic/coupons_wishlist/cubit/wihslist_coupons_cubit.dart';
import 'package:acwadcom/features/user/wishlist/widgets/empty_wish_list.dart';

import '../../home/ui/widgets/build_list_coupons.dart';

class CouponsFavoritesScreen extends StatefulWidget {
  const CouponsFavoritesScreen({super.key});

  @override
  State<CouponsFavoritesScreen> createState() => _CouponsFavoritesScreenState();
}

class _CouponsFavoritesScreenState extends State<CouponsFavoritesScreen> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
        // Fetch the wishlist once when the screen is first initialized
    context.read<WishListCouponsCubit>().fetchFavoriteCoupons();

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListCouponsCubit, WishListCouponsState>(
      buildWhen: (previous, current) =>
          current is WishlistLoading ||
          current is WishlistLoaded ||
          current is WishlistFaluire||
          current is EmptyWishList,
      builder: (context, state) {
        return state.maybeWhen(
          wishlistLoading: () => BuildCustomLoader(),
          wishlistLoaded: (coupons) => BuildListCoupons(coupons: coupons),
          emptyWishList: () => emptyWishList(context),
          orElse: () => Center(child: Container(child: myText(AText.error.tr(context)),),),
        );
      },
    );
  }
}