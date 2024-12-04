
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/UI/widgets/build_terms_and_condtions.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/helpers/popups/animation_loader.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/register_owner/register_owner_store_cubit.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/register_owner/register_owner_store_state.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/ui/widgets/build_create_account_button.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/ui/widgets/build_image_picker.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/ui/widgets/build_list_input_fileds.dart';

class RegisterOwnerStore extends StatelessWidget {

  final String selectStatus;
  const RegisterOwnerStore({super.key, required this.selectStatus});

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
              navigateNamedTo(context, Routes.verifyEmailScreen,"STOREOWNER");
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
    return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: ListView(
        children: [
          buildAppBarWithBackButton(context, isRTL(context), title: "",onPressedBack: () => navigateAndFinishNamed(context,Routes.loginScreen),),
          const SizedBox(height: 20),
          svgImage("_icLogo", height: 200.h),
          const SizedBox(height: 20),
          _buildTitle(context),
         const SizedBox(height: 20),
          buildImagePicker(context),
          const SizedBox(height: 30),
          buildInputFields(context),
          buildSpacerH(20.0),
          buildTermsAndCondtions(textColor: ManagerColors.kCustomColor,),
          buildSpacerH(20.0),
          const SizedBox(height: 40),
          buildCreateAccountButton(context),
        ],
      ),
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