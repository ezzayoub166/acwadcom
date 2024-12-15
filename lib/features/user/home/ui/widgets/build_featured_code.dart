import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/features/ownerStore/features/home/logic/home_owner/home_owner_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/show_required_dialog.dart';
import 'package:acwadcom/features/user/wishlist/logic/coupons_wishlist/cubit/wihslist_coupons_cubit.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/models/coupon_model.dart';

class BuildFeaturedCode extends StatefulWidget {
  final Coupon coupon;

  final bool isShowRemove;
  const BuildFeaturedCode({
    this.isShowRemove = false,
    super.key,
    required this.coupon,
  });

  @override
  State<BuildFeaturedCode> createState() => _BuildFeaturedCodeState();
}

class _BuildFeaturedCodeState extends State<BuildFeaturedCode> {


  
  @override
  Widget build(BuildContext context) {
    
    // Access the cubit to listen for wishlist updates
    final wishlistCubit = context.read<WishListCouponsCubit>();
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
                      widget.coupon.storeLogoURL ?? "", 100, 140, BoxFit.cover)),
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
                        widget.coupon.title,
                        color: ManagerColors.textColorDark,
                        fontSize: 16,
                        maxLines: 1,
                        fontWeight: FontWeightEnum.Bold.fontWeight,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${widget.coupon.discountRate}% ${AText.discount.tr(context)}",
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
                                text: AText.numberOfuse.tr(context),
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
                                text: widget.coupon.numberOfUse.toString(),
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
                  if (widget.isShowRemove)
                    InkWell(
                      child: svgImage("_icRemove", height: 20, width: 20),
                      onTap: () {
                        _showDeleteDialog(context,widget.coupon);
                      },
                    )
                  else
                         InkWell(
                      // Using BlocBuilder to update the heart icon based on the wishlist state
                      child:  BlocBuilder<WishListCouponsCubit, WishListCouponsState>(
                      buildWhen: (previous, current) => current is WishlistLoaded,
                      builder: (context, state) {
                        bool isFavorited = false;
                        if (state is WishlistLoaded) {
                          isFavorited = state.coupons.any((c) => c.couponId == widget.coupon.couponId);
                        }
                        return isFavorited
                            ? svgImage("_icHeart_click", height: 30, width: 30)
                            : svgImage("_icFavorites", height: 30, width: 30);
                      },
                    ),
                      onTap: () {

                        if(isLoggedInUser){
                      // Handle adding/removing from wishlist on tap
                        if (wishlistCubit.isInWishlist(widget.coupon)) {
                          wishlistCubit.removeCouponFromWishlist(widget.coupon);

                        } else {
                          wishlistCubit.addToWishList(widget.coupon);
                        }

                        }else{
                          showRequireLoginDialog(context);
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
  void _showDeleteDialog(BuildContext context , Coupon coupon) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.all(40),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                child: svgImage("icDeleteIcom", fit: BoxFit.fill),
              ),
              SizedBox(height: 16),
              myText(
                "Are you sure you delete the code?".tr(context),
                textAlign: TextAlign.center,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              myText(
                coupon.title,
                textAlign: TextAlign.center,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              SizedBox(height: 24),
              _buildDialogButtons(context, dialogContext),
                            SizedBox(height: 24),
          
          
            ],
          ),
        );
      },
    );
  }


  Widget _buildDialogButtons(BuildContext context, BuildContext dialogContext) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ManagerColors.yellowColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(AText.cancel.tr(context)),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(color: Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              context.read<HomeOwnerCubit>().emitRemoveCoupon(widget.coupon.couponId);
              Navigator.of(dialogContext).pop();
            },
            child: myText(AText.delete.tr(context), color: Colors.black),
          ),
        ),
      ],
    );
  }
}
