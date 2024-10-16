 import 'package:acwadcom/acwadcom_packges.dart';

Widget buildTextField(
      BuildContext context, String hintText, TextInputType keyboardType,
      {bool obscureText = false, TextEditingController? controller , required String? Function(String?)? validator
}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
    
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
      
        fillColor: ManagerColors.whiteBtnBackGround,
        
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: ManagerColors.kCustomColor)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: Colors.grey),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }