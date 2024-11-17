  import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/register_owner/register_owner_store_cubit.dart';

Widget buildCreateAccountButton(BuildContext context) {
    
        return RoundedButtonWgt(
          height: 60,
          width: double.infinity,
          title: AText.creatNewAccountlbl.tr(context),
          onPressed: () {
             if(context.read<RegisterOwnerStoreCubit>().formKey.currentState!.validate()){
               if(context.read<RegisterOwnerStoreCubit>().selectedImage!.path.isEmpty){
                TLoader.showWarningSnackBar(context, title: "plase set logo for your store");
               }else{
                // print("Emit State Register");
                 context.read<RegisterOwnerStoreCubit>().formKey.currentState!.save();

                 getIt<CacheHelper>().removeValueWithKey("tYPEUSER");
                getIt<CacheHelper>().saveValueWithKey("tYPEUSER" , "STOREOWNER");
                context.read<RegisterOwnerStoreCubit>().emitRegisterStates();
               

               }
             }
          } ,
          backgroundColor: ManagerColors.kCustomColor,
          foregroundColor: ManagerColors.myWhite,
        );
  }