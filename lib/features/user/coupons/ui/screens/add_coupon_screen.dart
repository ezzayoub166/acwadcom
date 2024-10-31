// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/ownerStore/features/home/logic/home_owner/home_owner_cubit.dart';
import 'package:acwadcom/features/ownerStore/features/home/logic/home_owner/home_owner_state.dart';
import 'package:acwadcom/features/user/coupons/logic/cubit/create_coupon_cubit_cubit.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/create_coupon_listener.dart';
import 'package:acwadcom/features/user/home/data/category_repository.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateCodeScreen extends StatefulWidget {
  const CreateCodeScreen({super.key});

  @override
  State<CreateCodeScreen> createState() => _CreateCodeScreenState();
}

class _CreateCodeScreenState extends State<CreateCodeScreen> {
  DateTime? pickedDate;
  bool isDateSelected = false; // To track if a date has been selected
  // final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    context.read<CreateCouponCubit>().fetchCategories();

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
        body: Stack(
            // alignment: Alignment.bottomLeft,
            children: [
              // Other widgets can be placed here
              Positioned(
                bottom: 100, // Adjust this to control vertical position
                left: -30,
                right: -30, // Adjust this to control horizontal position
                child:
                    myImage("img_create_code", height: 400.h, fit: BoxFit.fill),
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
                    // print(state);
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
                        tYPEUSER == "USER"
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
                                      ManagerValidator.validateTitleForCoupon(value??"", context),
                                  controller: context
                                      .read<CreateCouponCubit>()
                                      .titleController,
                                  textInputAction: TextInputAction.next),
                              buildSpacerH(10),
      
                              RoundedInputField(
                                  hintText: "Code herer..".tr(context),
                                  validator: (value) =>
                                      ManagerValidator.validateEmptyText(
                                          "Code", value ?? ""),
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
                                        "Discount rate", value ?? ""),
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
      
                              SelectDropList(
                                itemSelected: OptionItem(
                                    id: null, title: translatedchoseTheCategory),
                                dropListModel: context
                                    .read<CreateCouponCubit>()
                                    .listOfCategoriesOption,
                                onOptionSelected: (OptionItem optionItem) {
                                  //** TOD Set State .... */
                                  context
                                      .read<CreateCouponCubit>()
                                      .selectCategory(optionItem);
                                },
                              ),
                              buildSpacerH(10.0),
                              //** End Date ..... */
                              buildExpireDataWidget(context, selectedDate),
                              // buildSpacerH(10.0),
                              // RoundedInputField(
                              //     controller: context
                              //         .read<CreateCouponCubit>()
                              //         .numberOfUseController,
                              //     textInputType: TextInputType.number,
                              //     textInputAction: TextInputAction.done,
                              //     hintText: AText.numberOfuse.tr(context),
                              //     validator: (value) =>
                              //         ManagerValidator.validateNumberOfUser(
                              //             value ?? "", context)),
                              // buildSpacerH(10.0),
                              buildSpacerH(10.0),
                              //* Additional Terms *
                              AdditionalTermsCardWidget(),
                              buildSpacerH(20.0),
                              //** Save Button and Cancle */
      
                              Column(
                                children: [
                                  RoundedButtonWgt(
                                      title: AText.save.tr(context),
                                      onPressed: () {
                                        validateThenCreatedCode(context);
                                      }),
                                  buildSpacerH(10.0),
                                  RounderBorderCancelButton()
                                ],
                              ),
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
      if (context.read<CreateCouponCubit>().optionItemSelected?.id == null) {
        TLoader.showErrorSnackBar(context,
            title: "Required field".tr(context),
            message: "Please enter your store category.".tr(context));
      }
      if (context.read<CreateCouponCubit>().dateItem == null) {
        TLoader.showErrorSnackBar(context,
            title: "Required field".tr(context),
            message: "Please select an expiration date.".tr(context));
      }
      // print("object");
      context.read<CreateCouponCubit>().addCoupon();
    }
  }

  Widget buildImagePicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "Download store logo".tr(context),
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "JPG or PNG or SVG\n(Max 128*128 pixels)".tr(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(width: 5),
        BlocBuilder<CreateCouponCubit, CreateCouponState>(
          buildWhen: (previous, current) =>
              current is LoadedSetLogoStore ||
              current is LoadingSetLogoStore,
          builder: (context, state) {
            return state.maybeWhen(
                loadingSetLogoStore: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                loadedSetLogoStore: (imageURL) => CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(File(imageURL.path))),
                orElse: () => GestureDetector(
                    child: svgImage("_icAddImageFrame"),
                    onTap: () =>
                        context.read<CreateCouponCubit>().pickImage()));
          },
        )
      ],
    );
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
                              // setState(() {
                              //   pickedDate = dateTime;
                              //   isDateSelected = true;
                              //   _dateController.text =
                              //       "${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}";
                              // });
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
}
