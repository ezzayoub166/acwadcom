import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/admin/logic/request/cubit/control_coupons_cubit.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/constants/strings.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/models/coupon_request.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/home_owner/home_owner_cubit.dart';
import 'package:extended_image/extended_image.dart';

class DiscountCodeDeatilsAdmin extends StatelessWidget {
  final CouponRequest couponRequest;
  const DiscountCodeDeatilsAdmin({super.key, required this.couponRequest});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final coupon = couponRequest.coupon;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: myText(AText.detilsDiscount.tr(context),
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: ManagerColors.kCustomColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Store Logo (Top Circle Avatar)
              ClipOval(
                child: extendedImageWgt(
                    coupon.storeLogoURL ?? "", 100, 100, BoxFit.fill),
              ),
              SizedBox(height: 16),

              // Store Name

              myText(
                coupon.ownerCoupon.userName,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 16),

              // Fields (Discount code, Discount Percentage, Website link, etc.)
              buildInfoField(
                  AText.discountcode.tr(context), coupon.code, context),
              buildInfoField(AText.discontrate.tr(context),
                  "${AText.discontrate}${coupon.discountRate}", context),
              buildInfoField(
                  AText.linkofWebsite.tr(context), coupon.storeLink, context),
              buildInfoField(
                  AText.category.tr(context), coupon.category!.title, context),
              // buildInfoField(AText.stateData.tr(context), "2024-3-30", context),
              buildInfoField(AText.endDate.tr(context),
                  coupon.endData.toString(), context),

              // Notes Section
              buildNotesField(
                  AText.someNotes.tr(context), coupon.additionalTerms, context),

              SizedBox(height: 24),

              // Accept and Reject Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildActionButton(AText.accept.tr(context),
                      ManagerColors.kCustomColor, context, () {
                    context
                        .read<ControlCouponsCubit>()
                        .emitApproveCouponRequest(
                            coupon: coupon);
                  }),
                  buildSpacerH(10.0),
                  buildActionButton(
                      AText.reject.tr(context), Colors.red, context, () {}),
                ],
              ),
              BlocListener<ControlCouponsCubit, ControlCouponsState>(
                listenWhen: (previous, current) =>
                    current is ApproveCouponRequest ||
                    current is FaluireapproveCouponRequest ||
                    current is RejectCouponRequest ||
                    current is LoadingARCouponRequest,
                listener: (context, state) {
                  state.whenOrNull(
                      loadingARCouponRequest: () => BuildCustomLoader(),
                      approveCouponRequest: () {
                        TLoader.showSuccessSnackBar(context,
                            title: AText.addSuccessCoupon.tr(context),
                            message: AText.msgSuccessAddedForAdmin.tr(context));
                        context.pop();
                      },
                      faluireapproveCouponRequest: (error) {
                        TLoader.showErrorSnackBar(context,
                            title: AText.error.tr(context));
                      },
                      rejectCouponRequest: () {
                        //TODO: Reject Coupon Request ......
                      });
                },
                child: SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Helper Method for Info Fields
  Widget buildInfoField(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myText(
            label,
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Method for Notes Field
  Widget buildNotesField(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myText(
            label,
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          Container(
            height: 100, // Fixed height for Notes Field
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Method for Action Buttons
  Widget buildActionButton(
      String label, Color color, BuildContext context, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
