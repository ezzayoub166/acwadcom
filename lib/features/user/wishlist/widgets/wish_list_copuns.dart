import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/wishlist/widgets/empty_wish_list.dart';

class WishListCopuns extends StatefulWidget {

    final List<String> favCoupns = [];

   WishListCopuns({super.key});

  @override
  State<WishListCopuns> createState() => _WishListCopunsState();


}

class _WishListCopunsState extends State<WishListCopuns> {
  @override
  Widget build(BuildContext context) {
    return emptyWishList(context)    ;
  }
}