import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterOwnerStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30),
        child: ListView(
        
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildAppBarWithBackButton(context, isRTL(context) , title: ""),
            SizedBox(height: 44.h), // Top spacing
            // Logo
            svgImage("_icLogo", height: 200.h),
            SizedBox(height: 20.h),
            // Page title

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'أضف متجرك',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.h),
                // Store Logo Upload Section
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'تحميل شعار المتجر',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'JPG أو PNG أو SVG\n( الحد الأقصى 128*128 بيكسل )',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    // buildSpacerW(10),

                    GestureDetector(
                      onTap: () {
                        // Add your logo upload functionality here
                      },
                      child: svgImage("_icAddImageFrame")
                    ),

                    // SizedBox(height: 15.h),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.h),
            // Input Fields
            Column(
              children: [
                _buildTextField(AText.storeName.tr(context), TextInputType.text),
                SizedBox(height: 16.h),
                _buildTextField(AText.enterYourLikeStore.tr(context), TextInputType.url),
                SizedBox(height: 16.h),
                _buildTextField(
                    AText.email.tr(context), TextInputType.emailAddress),
                SizedBox(height: 16.h),
                _buildTextField(AText.yourPassword.tr(context), TextInputType.visiblePassword,
                    obscureText: true),
              ],
            ),
            SizedBox(height: 40.h),
            // Create Account Button
            RoundedButtonWgt(
              height: 60,
              width: double.infinity,
              title: AText.creatNewAccountlbl.tr(context), onPressed: (){} , backgroundColor: ManagerColors.kCustomColor ,foregroundColor: ManagerColors.myWhite,)
          ],
        ),
      ),
    );
  }

  // Function to build text fields
  Widget _buildTextField(String hintText, TextInputType keyboardType,
      {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }
}
