import 'package:acwadcom/features/user/explore/ui/widget/build_list_of_all_stores.dart';
import 'package:acwadcom/features/user/wishlist/logic/coupons_wishlist/cubit/wihslist_coupons_cubit.dart';

import '../../../../acwadcom_packges.dart';
import '../../../../common/widgets/build_custom_loader.dart';
import '../../explore/ui/widget/build_list_featured_stores.dart';
import '../logic/cubit/wishlist_cubit.dart';
import '../widgets/empty_wish_list.dart';

class StoresWishListScreen extends StatefulWidget {
  const StoresWishListScreen({
    super.key,

  });

  @override
  State<StoresWishListScreen> createState() => _StoresWishListScreenState();
}

class _StoresWishListScreenState extends State<StoresWishListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
            context.read<WishlistStoresCubit>().fetchWishListForStores();

  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<WishlistStoresCubit,WishListStoresState>(
        buildWhen: (previous,current) => current is WishlistStoresLoading || current is WishlistStoresLoaded || current is WishlistStoresFaluire || current is EmptyStoresWishList,
        builder: (context,state) {
          return state.maybeWhen(
              wishlistStoresLoading: () => BuildCustomLoader(),
              wishlistStoresLoaded: (stores) => BuildlistOfAllStores(stores: stores,colorForITem : const Color(0xffF5F5F5)),
              emptyStoresWishList: () => emptyWishList(context),
              wishlistStoresFaluire: (error) => setupError(),
              orElse: (){return emptyWishList(context);});
        });
  }

  Widget setupError() {
    return const SizedBox.shrink();
  }
}