import '../../../../acwadcom_packges.dart';
import '../../../../common/widgets/build_custom_loader.dart';
import '../../explore/ui/widget/build_list_featured_stores.dart';
import '../logic/cubit/wishlist_cubit.dart';
import '../widgets/empty_wish_list.dart';

class StoresWishListScreen extends StatelessWidget {
  const StoresWishListScreen({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit,WishlistState>(
        buildWhen: (previous,current) => current is WishlistLoading || current is WishlistStoresLoaded || current is WishlistFaluire,
        builder: (context,state) {
          return state.maybeWhen(
              wishlistLoading: () => BuildCustomLoader(),
              wishlistStoresLoaded: (stores) => BuildListFeaturedStores(stores: stores),
              emptyWishList: () => emptyWishList(context),
              wishlistFaluire: (error) => setupError(),
              orElse: (){return emptyWishList(context);});
        });
  }

  Widget setupError() {
    return const SizedBox.shrink();
  }
}