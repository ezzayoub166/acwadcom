  import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/register_owner/register_owner_store_cubit.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/ui/widgets/build_text_filed.dart';

Widget buildInputFields(BuildContext context) {
    final cubit = context.read<RegisterOwnerStoreCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          RoundedInputField(
            // context: context,
            hintText:    AText.storeName.tr(context),
            textInputType:  TextInputType.text,
            controller: cubit.nameOfStoreController,
            validator: (value) => ManagerValidator.validateEmptyText(AText.storeName.tr(context), value??""),
          ),
          SizedBox(height: 16.h),
          RoundedInputField(
            validator: (value) => ManagerValidator.validateURL(value, context) ,
            // context:  context,
            hintText:  AText.enterYourLikeStore.tr(context),
            textInputType:  TextInputType.url,
            controller: cubit.linkOfStore,
          ),
          SizedBox(height: 16.h),
          RoundedInputField(
            validator: (value) => ManagerValidator.validateEmail(value, context) ,
            // context:  context,
            hintText:  AText.email.tr(context),
            textInputType:  TextInputType.emailAddress,
            controller: cubit.emailController,
          ),
          SizedBox(height: 16.h),
          RoundedInputField(
            validator: (value) => ManagerValidator.validateTitleForCoupon(value??"", context) ,
            // context:  context,
            hintText:  AText.deatilsStore.tr(context),
            textInputType:  TextInputType.text,
            controller: cubit.deatilsStore,
          ),
          SizedBox(height: 16.h),

           RoundedInputField(
            validator: (value) => ManagerValidator.validatePhoneNumber(value,context: context), 
            // context:  context,
            hintText:  AText.phoneNumber.tr(context),
            textInputType:  TextInputType.number,
            controller: cubit.phoneController,
          ),
          SizedBox(height: 16.h),
          RoundedInputField(
            validator: (value) => ManagerValidator.validatePassword(value, context),
            // context:  context,
            hintText:  AText.yourPassword.tr(context),
            textInputType:  TextInputType.visiblePassword,
            isSecure: true,
            controller: cubit.passwordController,
          ),
        ],
      ),
    );
  }