import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/features/admin/logic/home_admin_cubit/cubit/home_admin_cubit.dart';
import 'package:acwadcom/models/coupon_model.dart';

class BuildItmCodeForAdmin extends StatelessWidget {
  final Coupon coupon;
  const BuildItmCodeForAdmin({
    super.key,
    required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
     DateTime currentDate = DateTime.now();
      Timestamp currentTimestamp = Timestamp.fromDate(currentDate);
      final isExp = coupon.endData.compareTo(currentTimestamp);
    return BlocBuilder<HomeAdminCubit, HomeAdminState>(
      buildWhen: (previous, current) =>
          current is LoadingRemove ||
          current is SucessRemove ||
          current is FaluireRemove,
      builder: (context, state) {
        return state.maybeWhen(
          loadingRemove: () => BuildCustomLoader(),
          sucessRemove: () => SizedBox(),
          orElse: () => Container(
            height: isExp==-1 ? 140 : 120,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xffF2F2F2), width: 2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCouponImage(),
                buildSpacerW(10),
                _buildCouponDetails(context,isExp),
              ],
            ),
          ),
        );
      },
    );
  }
  //!! MARK FOR Know the is coupon is expired ...

  Widget buildExpiredMark(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(10),
    ),
    child: myText(
      "Expired", // Translatable text
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
}

  Widget _buildCouponImage() {
    return Expanded(
      flex: 4,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 5.0,
        child: extendedImageWgt(coupon.storeLogoURL ?? "", 100, 100, BoxFit.cover),
      ),
    );
  }

  Widget _buildCouponDetails(BuildContext context,int isExp) {
    return Expanded(
      flex: 9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTitleRow(context),
          _buildDiscountText(context),
          _buildNumberOfUseRow(context),
          isExp == -1  ? buildExpiredMark(context):SizedBox(height: 0,),
        ],
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        myText(
          coupon.title,
          color: ManagerColors.textColorDark,
          fontSize: 18,
        ),
        InkWell(
          child: svgImage("_icRemove", height: 20, width: 20),
          onTap: () => _showDeleteDialog(context),
        ),
      ],
    );
  }

  Widget _buildDiscountText(BuildContext context) {
    return myText(
      "15% ${AText.discount.tr(context)}",
      color: ManagerColors.kCustomColor,
      fontWeight: FontWeightEnum.Bold.fontWeight,
      fontSize: 20,
    );
  }

  Widget _buildNumberOfUseRow(BuildContext context) {
    return Row(
      children: [
        svgImage("profile-tick", height: 18, width: 18),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: AText.numberOfuse,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ManagerColors.textColorDarkDouble,
                    ),
              ),
              TextSpan(
                text: ":",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ManagerColors.textColorDarkDouble,
                    ),
              ),
              TextSpan(
                text: coupon.numberOfUse.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ManagerColors.textColor,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.all(24),
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
              context.read<HomeAdminCubit>().emitRemoveCoupon(coupon.couponId);
              Navigator.of(dialogContext).pop();
            },
            child: myText(AText.delete.tr(context), color: Colors.black),
          ),
        ),
      ],
    );
  }
}
