// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/coupons/logic/cubit/create_coupon_cubit_cubit.dart';

  Widget buildDropListCategories({required BuildContext context ,  required String translatedchoseTheCategory,
    required CategoryModel newValue,}) {
    return BlocBuilder<CreateCouponCubit, CreateCouponState>(
      buildWhen: (previous, current) => current is CategorySelected,
      builder: (context, state) {
        return state.maybeWhen(
          categorySelected: (optionItemSelected) {
           return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white),
          height: 50,
          width: double.infinity,
          child: DropdownButton<CategoryModel>(
              alignment:
                  AlignmentDirectional.topCenter,
              focusColor: ManagerColors.kCustomColor,
              underline: SizedBox(
                height: 0,
              ),
              dropdownColor: Colors.white,
              isExpanded: true,
              borderRadius: BorderRadius.circular(30),
              itemHeight: 50,
              hint: myText(translatedchoseTheCategory,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              onChanged:
                  (CategoryModel? changedValue) {
                //  setState(() {
                //    newValue;
                //    print(newValue);
                //  });
                context
                    .read<CreateCouponCubit>()
                    .selectCategory(changedValue!);
              },
              value: optionItemSelected,
              items: bLISTOFCATEGORY
                  .map((CategoryModel value) {
                return DropdownMenuItem<
                    CategoryModel>(
                  value: value,
                  child: myText(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      getIt<CacheHelper>()
                                  .getChacedLanguageCode() ==
                              "en"
                          ? value.title["en"]
                          : value.title["ar"]),
                );
              }).toList()),
        );
        },
        orElse: () {
           return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white),
          height: 50,
          width: double.infinity,
          child: DropdownButton<CategoryModel>(
              alignment:
                  AlignmentDirectional.topCenter,
              focusColor: ManagerColors.kCustomColor,
              underline: SizedBox(
                height: 0,
              ),
              dropdownColor: Colors.white,
              isExpanded: true,
              borderRadius: BorderRadius.circular(30),
              itemHeight: 50,
              hint: myText(translatedchoseTheCategory,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              onChanged:
                  (CategoryModel? changedValue) {
                //  setState(() {
                //    newValue;
                //    print(newValue);
                //  });
                context
                    .read<CreateCouponCubit>()
                    .selectCategory(changedValue!);
              },
              value: newValue,
              items: bLISTOFCATEGORY
                  .map((CategoryModel value) {
                return DropdownMenuItem<
                    CategoryModel>(
                  value: value,
                  child: myText(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      getIt<CacheHelper>()
                                  .getChacedLanguageCode() ==
                              "en"
                          ? value.title["en"]
                          : value.title["ar"]),
                );
              }).toList()),
        );
        },
        
        
        );
    
       
      }
      ,
    );
  }
