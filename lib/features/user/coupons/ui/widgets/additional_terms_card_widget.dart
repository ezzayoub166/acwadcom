import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/coupons/logic/cubit/create_coupon_cubit_cubit.dart';

class AdditionalTermsCardWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 168.h,
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(20), // Rounded corners
        border: Border.all(color: Colors.grey.shade300, width: 1), // Border
      ),
      // padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        controller: context.read<CreateCouponCubit>().additionalTerms,
        validator:(value) => ManagerValidator.validateEmptyText("Additional Terms".tr(context), value??""),
        maxLines: null, // Allows the text field to expand vertically
        keyboardType: TextInputType.multiline,
        // textAlign: TextAlign.right, // Align text to the right for Arabic or RTL languages
        decoration: InputDecoration(
          // border: InputBorder.none, // Removes the border around the TextField
          hintText: "Additional Terms".tr(context),
          // hintStyle: TextStyle(
          //   fontSize: 18,
          //   color: Colors.grey.shade700,
          //   fontWeight: FontWeight.bold,
          // ),
          // fillColor: Colors.white, // Background color of the input field
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // Circular border
            borderSide: const BorderSide(
              color: Colors.transparent, // No border color
              width: 0,
            ),
          ),
           errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.transparent, // No border color on error
                  width: 0,
                ),
              ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // Circular border
            borderSide: const BorderSide(
              color: Colors.transparent, // No border color
              width: 0,
            ),
          ),
        ),
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
