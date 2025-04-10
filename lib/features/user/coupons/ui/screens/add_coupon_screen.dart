// ignore_for_file: use_build_context_synchronously

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/coupons/logic/cubit/create_coupon_cubit_cubit.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_image_picker.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/create_coupon_listener.dart';

class CreateCodeScreen extends StatefulWidget {
  const CreateCodeScreen({super.key});

  @override
  State<CreateCodeScreen> createState() => _CreateCodeScreenState();
}

class _CreateCodeScreenState extends State<CreateCodeScreen> {
  DateTime? pickedDate;
  bool isDateSelected = false; // To track if a date has been selected
  // final TextEditingController _dateController = TextEditingController();
  CategoryModel? newValue;

  @override
  void initState() {
    super.initState();
    context.read<CreateCouponCubit>().fetchCategories();
  }

  SizedBox buildExpireDataWidget(BuildContext context, DateTime? selectedDate) {
    return SizedBox(
        width: double.infinity,
        child: TextFormField(
          controller: context.read<CreateCouponCubit>().dateController,
          // enabled: false, // Disable when a date is selected
          validator: (value) {
            if (value == null || value.isEmpty || pickedDate == null) {
              return "Please select an expiration date.".tr(context);
            }
            return null; // Input is valid
          },
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            errorStyle: GoogleFonts.cairo(
                color: Colors.red, // Change error message text color
                fontSize: 10.sp,
                fontWeight: FontWeight.bold // Error text font size
                ),
            hintText: AText.exDate.tr(context),
            hintStyle: const TextStyle(
                color: ManagerColors.kCustomColor, fontSize: 16),
            filled: true,
            suffixIcon: IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: selectedDate == null
                  ? () async {
                      // Capture the correct context before opening the dialog
                      final parentContext = context;
                      pickedDate = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AdoptiveCalendar(
                            backgroundColor: ManagerColors.kCustomColor,
                            barColor: ManagerColors.kCustomColor,
                            initialDate: DateTime.now(),
                            onSelection: (dateTime) {
                              parentContext
                                  .read<CreateCouponCubit>()
                                  .selectDate(dateTime ?? DateTime.now());
        
                            },
                          );
                        },
                      );
                    }
                  : null, // Disable the button when a date is selected
            ),
            fillColor: Colors.white,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent, // No border color on error
                width: 0,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    //! To Pass it to State ..
    final translatedExDateTitle = AText.exDate.tr(context);
    final translatedchoseTheCategory = AText.choseTheCategory.tr(context);

    context.read<CreateCouponCubit>().dateController.text =
        translatedExDateTitle;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: ManagerColors.whiteBtnBackGround,
        body: Stack(children: [
          // Other widgets can be placed here
          Positioned(
            bottom: 100, // Adjust this to control vertical position
            left: -30,
            right: -30, // Adjust this to control horizontal position
            child: myImage("img_create_code", height: 400.h, fit: BoxFit.fill),
          ),
          BlocBuilder<CreateCouponCubit, CreateCouponState>(
            buildWhen: (previous, current) =>
                current is DateSelected ||
                current is CategoriesLoaded ||
                current is CategorySelected,
            builder: (context, state) {
              DateTime? selectedDate;

              // !! check if category is Selected
              if (state is CategorySelected) {
                context.read<CreateCouponCubit>().optionItemSelected =
                    state.optionItemSelected;
              }

              if (state is DateSelected) {
                selectedDate = state.selectedDate;
                context.read<CreateCouponCubit>().dateController.text =
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
              }

              return Positioned.fill(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 20, 10),
                child: ListView(
                  children: [
                    svgImage("_icAddNewCoupon",
                        width: screenWidth * 0.5, height: screenWidth * 0.5),
                    myText(
                      "Create Coupon".tr(context),
                      fontSize: 24,
                      fontWeight: FontWeightEnum.SemiBold.fontWeight,
                      color: ManagerColors.kCustomColor,
                    ),
                    buildSpacerH(20.0),
                    tYPEUSER != "STOREOWNER"
                        ? buildImagePicker(context)
                        : const SizedBox(),
                    buildSpacerH(20.0),

                    //Fileds........
                    Form(
                      key: context.read<CreateCouponCubit>().formKey,
                      child: Column(
                        children: [
                          RoundedInputField(
                              hintText:
                                  "Short title , like store name".tr(context),
                              validator: (value) =>
                                  ManagerValidator.validateTitleForCoupon(
                                      value ?? "", context),
                              controller: context
                                  .read<CreateCouponCubit>()
                                  .titleController,
                              textInputAction: TextInputAction.next),
                          buildSpacerH(10),

                          RoundedInputField(
                              hintText: "Code herer..".tr(context),
                              validator: (value) =>
                                  ManagerValidator.validateEmptyText(
                                      "Discount code", value ?? "", context),
                              controller: context
                                  .read<CreateCouponCubit>()
                                  .codeTextController,
                              textInputAction: TextInputAction.next),
                          buildSpacerH(10),
                          RoundedInputField(
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            hintText: AText.discontrate.tr(context),
                            validator: (value) =>
                                ManagerValidator.validateEmptyText(
                                    "Discount rate", value ?? "", context),
                            controller: context
                                .read<CreateCouponCubit>()
                                .discountRateController,
                          ),

                          buildSpacerH(10.0),
                          RoundedInputField(
                              textInputAction: TextInputAction.done,
                              hintText: AText.enterYourLikeStore.tr(context),
                              controller: context
                                  .read<CreateCouponCubit>()
                                  .storeLinkController,
                              validator: (value) =>
                                  ManagerValidator.validateURL(
                                      value ?? "", context)),
                          buildSpacerH(10),
                          //**Category Choose */

                          // Category selection drop down
                          buildDropListOfCategories(translatedchoseTheCategory: translatedchoseTheCategory, newValue: newValue),
                          buildSpacerH(10.0),
                          //** End Date ..... */
                          buildExpireDataWidget(
                              context, selectedDate),

                          buildSpacerH(10.0),
                          //* Additional Terms *
                          AdditionalTermsCardWidget(
                            controller: context
                                .read<CreateCouponCubit>()
                                .additionalTerms,
                          ),
                          buildSpacerH(20.0),
                          //** Save Button and Cancle */

                          RoundedButtonWgt(
                              title: AText.save.tr(context),
                              onPressed: () {
                                validateThenCreatedCode(context);
                              }),
                          buildSpacerH(10.0),
                          RounderBorderCancelButton(),
                          const CreateCouponListener(),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
            },
          )
        ]),
      ),
    );
  }


  void validateThenCreatedCode(BuildContext context) {
    if (context.read<CreateCouponCubit>().formKey.currentState!.validate()) {
      if (context.read<CreateCouponCubit>().optionItemSelected?.categoryId ==
          null) {
        TLoader.showErrorSnackBar(context,
            title: "Required field".tr(context),
            message: "Please enter your store category.".tr(context));
      }
      if (context.read<CreateCouponCubit>().dateItem == null) {
        TLoader.showErrorSnackBar(context,
            title: "Required field".tr(context),
            message: "Please select an expiration date.".tr(context));
      }
      if (tYPEUSER == "Admin") {
        context.read<CreateCouponCubit>().addCouponByAdmin();
      } else {
        context.read<CreateCouponCubit>().addCoupon();
      }
    }
  }
}

class buildDropListOfCategories extends StatelessWidget {
  const buildDropListOfCategories({
    super.key,
    required this.translatedchoseTheCategory,
    required this.newValue,
  });

  final String translatedchoseTheCategory;
  final CategoryModel? newValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCouponCubit, CreateCouponState>(
      buildWhen: (previous, current) =>
          current is CategorySelected,
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
      },
    );
  }
}
