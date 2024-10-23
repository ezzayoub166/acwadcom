import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/home/ui/home_screen.dart';
import 'package:acwadcom/features/user/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:acwadcom/features/user/wishlist/widgets/empty_wish_list.dart';

import '../../home/ui/widgets/build_list_coupons.dart';

class CouponsFavoritesScreen extends StatefulWidget {
  const CouponsFavoritesScreen({super.key});

  @override
  State<CouponsFavoritesScreen> createState() => _CouponsFavoritesScreenState();
}

class _CouponsFavoritesScreenState extends State<CouponsFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      buildWhen: (previous, current) =>
          current is WishlistLoading ||
          current is WishlistLoaded ||
          current is WishlistFaluire,
      builder: (context, state) {
        return state.maybeWhen(
          wishlistLoading: () => BuildCustomLoader(),
          wishlistLoaded: (coupons) => BuildListCoupons(coupons: coupons),
          emptyWishList: () => emptyWishList(context),
          orElse: () => emptyWishList(context),
        );
      },
    );
  }
}