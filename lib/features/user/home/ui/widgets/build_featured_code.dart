import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/features/user/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/features/ownerStore/features/home/widgets/custom_pop_dialog_delete.dart';

class BuildFeaturedCode extends StatelessWidget {
  final Coupon coupon;

  final bool isShowRemove;
  const BuildFeaturedCode({
    this.isShowRemove = false,
    super.key,
    required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
    // Access the cubit to listen for wishlist updates
    final wishlistCubit = context.read<WishlistCubit>();
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xffF2F2F2), width: 2)),
        child: Row(
          children: [
            //image of store ....
            Expanded(
              flex: 4,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius as needed
                  ),
                  clipBehavior: Clip.antiAlias,
                  elevation: 5.0,
                  child: extendedImageWgt(
                      coupon.storeLogoURL ?? "", 100, 140, BoxFit.cover)),
            ),

            buildSpacerW(10),
            Expanded(
              flex: 9,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //attributes => name of store , dicsount % , numer of use times ..
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      myText(
                        coupon.title,
                        color: ManagerColors.textColorDark,
                        fontSize: 16.sp,
                        maxLines: 2,
                        fontWeight: FontWeightEnum.Bold.fontWeight,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${coupon.discountRate}% ${AText.discount.tr(context)}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: ManagerColors.kCustomColor),
                      ),
                      Row(
                        children: [
                          svgImage("profile-tick", height: 18, width: 18),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: AText.numberOfuse,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color:
                                            ManagerColors.textColorDarkDouble)),
                            TextSpan(
                                text: ":",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color:
                                            ManagerColors.textColorDarkDouble)),
                            TextSpan(
                                text: " 100",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: ManagerColors.textColor))
                          ])),
                        ],
                      ),
                    ],
                  ),
                  //Favorite button..
                  if (isShowRemove)
                    InkWell(
                      child: svgImage("_icRemove", height: 20, width: 20),
                      onTap: () {
                        showConfirmDeleteDialog(context, coupon.title);
                      },
                    )
                  else
                         InkWell(
                      // Using BlocBuilder to update the heart icon based on the wishlist state
                      child: BlocBuilder<WishlistCubit, WishlistState>(
                        builder: (context, state) {
                          final isFavorited = (state is WishlistLoaded &&
                              state.coupons.any((c) => c.couponId == coupon.couponId));


                          return isFavorited ?svgImage("_icHeart_click" , height: 30 , width: 30) :svgImage("_icFavorites" , height: 30 , width: 30);


                        },
                      ),
                      onTap: () {
                        // Handle adding/removing from wishlist on tap
                        if (wishlistCubit.isInWishlist(coupon)) {
                          wishlistCubit.removeCouponFromWishlist(coupon);
                          
                        } else {
                          wishlistCubit.addToWishList(coupon);
                        }
                      },
                    )
                  
                ],
              ),
            ),
          ],
        ));
  }

  // Function to show the dialog
  void showConfirmDeleteDialog(BuildContext context, String codeName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          codeName: codeName,
          couponID: coupon.couponId,
        );
      },
    );
  }
}
