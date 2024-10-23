import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/explore/data/store_model.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_list_featured_stores.dart';
import 'package:acwadcom/features/user/home/ui/home_screen.dart';
import 'package:acwadcom/features/user/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:acwadcom/features/user/wishlist/widgets/empty_wish_list.dart';

import '../../home/ui/widgets/build_list_coupons.dart';

class StoresFavoritesScreen extends StatefulWidget {
  const StoresFavoritesScreen({super.key});

  @override
  State<StoresFavoritesScreen> createState() => _CouponsFavoritesScreenState();
}

class _CouponsFavoritesScreenState extends State<StoresFavoritesScreen> {

    final List<StoreModel> storesF = [
      StoreModel(
          name: "فيد بيكس",
          imageUrl: "https://logodix.com/logo/2310.png",
          deatilsForCopunns: "أكواد خصم تصل الى %20"),
      StoreModel(
          name: "Smile Shop",
          imageUrl:
              "https://img.freepik.com/free-vector/gradient-instagram-shop-logo-template_23-2149704603.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727308800&semt=ais_hybrid",
          deatilsForCopunns: "أكواد خصم تصل الى %20"),
      StoreModel(
          name: "ابل",
          imageUrl:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHuSKg3KQINvWnpNkd9brsgcZmMyjYIeuNjQ&s",
          deatilsForCopunns: "أكواد خصم تصل الى %20"),
      StoreModel(
          name: "لوكي",
          imageUrl:
              "https://www.robotbutt.com/wp-content/uploads/2016/02/goodwill-logo.jpg",
          deatilsForCopunns: "أكواد خصم تصل الى %20"),
    ];
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
          wishlistStoresLoaded: (stores) => BuildListFeaturedStores(stores: stores),
          emptyWishList: () => emptyWishList(context),
          orElse: () => emptyWishList(context),
        );
      },
    );
  }
}