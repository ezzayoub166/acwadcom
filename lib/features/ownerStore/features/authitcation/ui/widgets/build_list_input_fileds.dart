  import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/custom_phone_number_filed.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/register_owner/register_owner_store_cubit.dart';

Widget buildInputFields(BuildContext context) {
    final cubit = context.read<RegisterOwnerStoreCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
           //* MARK: Store Name 
          RoundedInputField(
            // context: context,
            hintText:    AText.storeName.tr(context),
            textInputType:  TextInputType.text,
            controller: cubit.nameOfStoreController,
            textInputAction: TextInputAction.next,
            validator: (value) => ManagerValidator.validateEmptyText(AText.storeName, value??"",context),
          ),
          SizedBox(height: 16.h),
          //* MARK: Store Link

          RoundedInputField(
            validator: (value) => ManagerValidator.validateURL(value, context) ,
            // context:  context,
            hintText:  AText.enterYourLikeStore.tr(context),
            textInputType:  TextInputType.url,
            textInputAction: TextInputAction.next,

            controller: cubit.linkOfStore,
          ),
          SizedBox(height: 16.h),
              //* MARK: email 

          RoundedInputField(
            validator: (value) => ManagerValidator.validateEmail(value, context) ,
            // context:  context,
            hintText:  AText.email.tr(context),
            textInputType:  TextInputType.emailAddress,
            controller: cubit.emailController,
          ),
          SizedBox(height: 16.h),
            //* MARK: descreption for stroe  
          RoundedInputField(
            validator: (value) => ManagerValidator.validateTitleForCoupon(value??"", context) ,
            // context:  context,
            hintText:  AText.deatilsStore.tr(context),
            textInputType:  TextInputType.text,
            controller: cubit.deatilsStore,
          ),
          SizedBox(height: 16.h),
          //* MARK: mobile number 

          CustomPhoneNumberInput(
            controller: context.read<RegisterOwnerStoreCubit>().phoneController,),
          //  RoundedInputField(
          //   validator: (value) => ManagerValidator.validatePhoneNumber(value,context: context), 
          //   // context:  context,
          //   hintText:  AText.phoneNumber.tr(context),
          //   textInputType:  TextInputType.number,
          //   controller: cubit.phoneController,
          // ),
          SizedBox(height: 16.h),
        //* MARK: password 

          RoundedInputField(
            validator: (value) => ManagerValidator.validatePassword(value, context),
            // context:  context,
            hintText:  AText.yourPassword.tr(context),
            textInputType:  TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            isSecure: true,
            controller: cubit.passwordController,
          ),
        ],
      ),
    );
  }