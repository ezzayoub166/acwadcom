// import 'package:acwadcom/acwadcom_packges.dart';
// import 'package:acwadcom/features/coupons/ui/widgets/build_app_bar_with_back_button.dart';

// class RegisterOwnerStore extends StatelessWidget {
//   const RegisterOwnerStore({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30),
//         child: ListView(

//           // crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             buildAppBarWithBackButton(context, isRTL(context) , title: ""),
//             SizedBox(height: 44.h), // Top spacing
//             // Logo
//             svgImage("_icLogo", height: 200.h),
//             SizedBox(height: 20.h),
//             // Page title

//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'أضف متجرك',
//                   style: TextStyle(
//                     fontSize: 24.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 // Store Logo Upload Section
//                 Row(
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                           'تحميل شعار المتجر',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                         SizedBox(height: 5.h),
//                         Text(
//                           'JPG أو PNG أو SVG\n( الحد الأقصى 128*128 بيكسل )',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                     // buildSpacerW(10),

//                     GestureDetector(
//                       onTap: () {
//                         // Add your logo upload functionality here
//                       },
//                       child: svgImage("_icAddImageFrame")
//                     ),

//                     // SizedBox(height: 15.h),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 30.h),
//             // Input Fields
//             Column(
//               children: [
//                 _buildTextField(AText.storeName.tr(context), TextInputType.text),
//                 SizedBox(height: 16.h),
//                 _buildTextField(AText.enterYourLikeStore.tr(context), TextInputType.url),
//                 SizedBox(height: 16.h),
//                 _buildTextField(
//                     AText.email.tr(context), TextInputType.emailAddress),
//                 SizedBox(height: 16.h),
//                 _buildTextField(AText.yourPassword.tr(context), TextInputType.visiblePassword,
//                     obscureText: true),
//               ],
//             ),
//             SizedBox(height: 40.h),
//             // Create Account Button
//             RoundedButtonWgt(
//               height: 60,
//               width: double.infinity,
//               title: AText.creatNewAccountlbl.tr(context), onPressed: (){} , backgroundColor: ManagerColors.kCustomColor ,foregroundColor: ManagerColors.myWhite,)
//           ],
//         ),
//       ),
//     );
//   }

//   // Function to build text fields
//   Widget _buildTextField(String hintText, TextInputType keyboardType,
//       {bool obscureText = false}) {
//     return TextField(
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         hintText: hintText,
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.r),
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
//       ),
//     );
//   }
// }


import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/authtication/UI/screens/verify_email_screen.dart';
import 'package:acwadcom/features/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/helpers/popups/animation_loader.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:acwadcom/ownerStore/features/authitcation/logic/register_owner/register_owner_store_cubit.dart';
import 'package:acwadcom/ownerStore/features/authitcation/logic/register_owner/register_owner_store_state.dart';
import 'package:acwadcom/ownerStore/features/authitcation/ui/widgets/build_create_account_button.dart';
import 'package:acwadcom/ownerStore/features/authitcation/ui/widgets/build_image_picker.dart';
import 'package:acwadcom/ownerStore/features/authitcation/ui/widgets/build_list_input_fileds.dart';

class RegisterOwnerStore extends StatelessWidget {
  const RegisterOwnerStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
        child: BlocConsumer<RegisterOwnerStoreCubit, RegisterOwnerStoreState>(
          // buildWhen: (previous, current) => current is ,
          listener: (context, state) {
            state.when(
              initial: (){}, 
              successRegister: (){
                              //Show Success Message
              Navigator.pop(context);
              TLoader.showSuccessSnackBar(context,
                  title: "Congratulation".tr(context),
                  message:
                      "Your account has been created! Verify email to continue");

              //Move to Verity Email Screen
              navigateNamedTo(context, Routes.verifyEmailScreen,UserType.storeOwner);
              // Get.to(() => VerifyEmailScreen(email: userCredential.user?.email));
                 
              }, 
              failureRegister: (error){
                    Navigator.pop(context);

              TLoader.showErrorSnackBar(context,
                  title: 'On Snap!', message: error.toString());
              }, 
              loadingRegister: (){
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => PopScope(
                      canPop: false,
                      child: Container(
                        color: ManagerColors.dark,
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 250,
                            ),
                            TAnimationLoaderWidget(
                                text: "We are processing your information...".tr(context),
                                animation: "assets/images/loading_sign.json")
                          ],
                        ),
                      )));
              }, 
              imageStoreinital: (){}, 
              imageStoreLoading: (){},
               imageStoreSelected: (image){}
               );
            // if (state is SuccessRegister) {
            //   // Navigate to the success screen or show a success message
            // } else if (state is FailureRegister) {
            //   // Show an error message
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text(state.error)),
            //   );
            },
          builder: (context, state) =>  _RegisterOwnerForm(),
        ),
      ),
    );
  }
}

class _RegisterOwnerForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        buildAppBarWithBackButton(context, isRTL(context), title: ""),
        const SizedBox(height: 20),
        svgImage("_icLogo", height: 200.h),
        const SizedBox(height: 20),
        _buildTitle(context),
       const SizedBox(height: 20),
        buildImagePicker(context),
        const SizedBox(height: 30),
        buildInputFields(context),
        const SizedBox(height: 40),
        buildCreateAccountButton(context),
      ],
    );
  }

  Widget _buildTitle(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
         "Add your store".tr(context),
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }





 

}