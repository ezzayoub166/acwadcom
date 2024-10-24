import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/features/user/wishlist/logic/coupons_wishlist/cubit/wihslist_coupons_cubit.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/features/ownerStore/features/home/widgets/custom_pop_dialog_delete.dart';

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

  bool isFavorited = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  
  @override
  Widget build(BuildContext context) {
    
    // Access the cubit to listen for wishlist updates
    final wishlistCubit = context.read<WishListCouponsCubit>();
;    return Container(
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
                        fontSize: 16.sp,
                        maxLines: 2,
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
                  if (widget.isShowRemove)
                    InkWell(
                      child: svgImage("_icRemove", height: 20, width: 20),
                      onTap: () {
                        showConfirmDeleteDialog(context, widget.coupon.title);
                      },
                    )
                  else
                         InkWell(
                      // Using BlocBuilder to update the heart icon based on the wishlist state
                      child: BlocBuilder<WishListCouponsCubit, WishListCouponsState>(
                        buildWhen: (previous, current) => current is WishlistLoaded,
                        builder: (context, state) {
                          if(state is WishlistLoaded){
                          isFavorited = 
                              state.coupons.any((c) => c.couponId == widget.coupon.couponId);


                          return isFavorited ? svgImage("_icHeart_click" , height: 30 , width: 30) :svgImage("_icFavorites" , height: 30 , width: 30);

                          }
                          return svgImage("_icFavorites" , height: 30 , width: 30);
                       

                        },
                      ),
                      onTap: () {
                        // Handle adding/removing from wishlist on tap
                        if (wishlistCubit.isInWishlist(widget.coupon)) {
                          wishlistCubit.removeCouponFromWishlist(widget.coupon);
                          
                        } else {
                          wishlistCubit.addToWishList(widget.coupon);
                        }

                        setState(() {
                          isFavorited !=isFavorited;
                        });
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
          couponID: widget.coupon.couponId,
        );
      },
    );
  }
}
