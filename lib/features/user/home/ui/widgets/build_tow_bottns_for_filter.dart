import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/Routing/app_router.dart';

class ButtonRowApplyCancle extends StatelessWidget {
  final String categoryID;
  final int rate;

  const ButtonRowApplyCancle(
      {super.key, required this.categoryID, this.rate = 0});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Cancel Button (Outlined)
        RounderBorderCancelButton(
          height: 60,
          width: 140.w,
        ),
        const SizedBox(width: 10), // Spacing between buttons
        // Apply Button (Filled)
        SizedBox(
          height: 60,
          width: 140.w,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ManagerColors.yellowColor, // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Rounded border
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Padding
            ),
            onPressed: () {
              // Action for the Apply button
              if (categoryID.isNotEmpty && rate != 0) {
                
                    // BlocProvider.of<FilterCouponsCubit>(context).emitFilterCoupons(categoryID, rate);
                    // context.read<FilterCouponsCubit>().emitFilterCoupons(categoryID,rate);
                    var obj = FilterItem(categoryID: categoryID, rate: rate);
                    navigateNamedTo(context, Routes.listOfFilterdCouponsScreen,obj);
              } else {
                TLoader.showWarningSnackBar(context,
                    title: "some values is empty , must filled it.");
              }
            },
            child: Text(
              AText.apply.tr(context),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color
              ),
            ),
          ),
        ),
      ],
    );
  }
}
