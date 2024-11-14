  import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/home/ui/widgets/show_required_dialog.dart';
import 'package:acwadcom/features/user/wishlist/logic/coupons_wishlist/cubit/wihslist_coupons_cubit.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/models/coupon_model.dart';


class BuildFavAndCopyWidget extends StatefulWidget {
  
  final Coupon coupon;
  const BuildFavAndCopyWidget({super.key, required this.coupon});

  @override
  State<BuildFavAndCopyWidget> createState() => _BuildFavAndCopyWidgetState();
}

class _BuildFavAndCopyWidgetState extends State<BuildFavAndCopyWidget> {

  bool isFavorited  = false;
  @override
  Widget build(BuildContext context) {
   return Flexible(
      flex: 2,
      child: Stack(
        alignment: Alignment.center,
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Positioned(
              top: 5,
              left: 0,
              child:            InkWell(
                      // Using BlocBuilder to update the heart icon based on the wishlist state
                      child: BlocBuilder<WishListCouponsCubit, WishListCouponsState>(
                        buildWhen: (previous, current) => current is WishlistLoaded,
                        builder: (context, state) {
                          if(state is WishlistLoaded){
                          isFavorited = 
                              state.coupons.any((c) => c.couponId == widget.coupon.couponId);


                          return isFavorited ? svgImage("_icHeart_click" , height: 20 , width: 20) :svgImage("_icFavorites" , height: 20 , width: 20);

                          }
                          return svgImage("_icFavorites" , height: 20 , width: 20);
                       

                        },
                      ),
                      onTap: () {
                        if(isLoggedInUser){
   // Handle adding/removing from wishlist on tap
                        if (context.read<WishListCouponsCubit>().isInWishlist(widget.coupon)) {
                          context.read<WishListCouponsCubit>().removeCouponFromWishlist(widget.coupon);
                          
                        } else {
                          context.read<WishListCouponsCubit>().addToWishList(widget.coupon);
                        }

                        setState(() {
                          isFavorited !=isFavorited;
                        });
                        }else{
                          showRequireLoginDialog(context);
                                                  }
                     
                      },
                    ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height *
                    0.04, // 10% from the top of the screen
                left: MediaQuery.of(context).size.width *
                    0.02, //2% from the left of the parent
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myText("${widget.coupon.discountRate}% ${AText.discountText.tr(context)}",
                        fontSize: 10,
                        fontWeight: FontWeightEnum.Bold.fontWeight),
                    buildSpacerH(5.0),
                    InkWell(
                      child: Container(
                        height: 25.h,
                        width: 50.w,
                        // padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        decoration: const BoxDecoration(
                            color: ManagerColors.yellowColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: myText(
                          AText.copy.tr(context),
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeightEnum.Bold.fontWeight,
                        )),
                      ),
                      onTap: () {
                        //** copy the cdoe for Coupon....... */
                        copyCouponToClipboard(widget.coupon, context);
                        
                      },
                    ),
                  ],
                ))
          ]),
    );
  }
}
