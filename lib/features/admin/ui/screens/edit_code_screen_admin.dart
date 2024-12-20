import 'dart:io';
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/admin/logic/edit_screen/cubit/edit_coupon_cubit.dart';
import 'package:acwadcom/features/admin/logic/home_admin_cubit/cubit/home_admin_cubit.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:lottie/lottie.dart';

class EditCouponScreen extends StatefulWidget {
  final Coupon coupon;

  const EditCouponScreen({super.key, required this.coupon});

  @override
  State<EditCouponScreen> createState() => _EditCouponScreenState();
}

class _EditCouponScreenState extends State<EditCouponScreen> {
  DateTime? pickedDate;
  bool isDateSelected = false;

  @override
  void initState() {
    super.initState();
    context.read<EditCouponCubit>().fetchCouponData(widget.coupon.couponId);
        context.read<EditCouponCubit>().fetchCategories();

  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final translatedExDateTitle = AText.exDate.tr(context);
    final translatedchoseTheCategory = AText.choseTheCategory.tr(context);
   var locale = getIt<CacheHelper>().getValueWithKey("LOCAL");


    context.read<EditCouponCubit>().dateController.text = translatedExDateTitle;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: ManagerColors.whiteBtnBackGround,
        body: Stack(
          children: [
            Positioned(
              bottom: 100,
              left: -30,
              right: -30,
              child:
                  myImage("img_create_code", height: 400.h, fit: BoxFit.fill),
            ),
            BlocBuilder<EditCouponCubit, EditCouponState>(
              buildWhen: (previous, current) =>
                  current is DateSelectedEditCoupon ||
                  current is CategoriesLoadedEditCoupon ||
                  current is CategorySelectedEditCoupon ||
                  current is CouponLoadedEditCoupon ||
                  current is SuccessEditCoupon ||
                  current is LoadingEditCoupon,
              builder: (context, state) {
                DateTime? selectedDate;

                if (state is CouponLoadedEditCoupon) {
                  final coupon = state.coupon;
                  // Update form with coupon data
                  context.read<EditCouponCubit>().titleController.text =
                      coupon.title;
                  context.read<EditCouponCubit>().codeTextController.text =
                      coupon.code;
                  context.read<EditCouponCubit>().discountRateController.text =
                      coupon.discountRate;
                  context.read<EditCouponCubit>().storeLinkController.text =
                      coupon.storeLink;
                  context.read<EditCouponCubit>().additionalTerms.text =
                      coupon.additionalTerms;
                  selectedDate = coupon.endData.toDate();
                }

                if (state is CategorySelectedEditCoupon) {
                  context.read<EditCouponCubit>().optionItemSelected =
                      state.optionItemSelected;
                }

                if (state is DateSelectedEditCoupon) {
                  selectedDate = state.selectedDate;
                  context.read<EditCouponCubit>().dateController.text =
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                }

                return Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 20, 10),
                    child: ListView(
                      children: [
                        svgImage("_icAddNewCoupon",
                            width: screenWidth * 0.5,
                            height: screenWidth * 0.5),
                        myText(
                          "Edit Coupon".tr(context),
                          fontSize: 24,
                          fontWeight: FontWeightEnum.SemiBold.fontWeight,
                          color: ManagerColors.kCustomColor,
                        ),
                        buildSpacerH(20.0),
                        tYPEUSER != "STOREOWNER"
                            ? buildImagePicker(context)
                            : const SizedBox(),
                        buildSpacerH(20.0),
                        Form(
                          key: context.read<EditCouponCubit>().formKey,
                          child: Column(
                            children: [
                              RoundedInputField(
                                hintText:
                                    "Short title, like store name".tr(context),
                                validator: (value) =>
                                    ManagerValidator.validateTitleForCoupon(
                                        value ?? "", context),
                                controller: context
                                    .read<EditCouponCubit>()
                                    .titleController,
                                textInputAction: TextInputAction.next,
                              ),
                              buildSpacerH(10),
                              RoundedInputField(
                                hintText: "Code here..".tr(context),
                                validator: (value) =>
                                    ManagerValidator.validateEmptyText(
                                        "Discount code", value ?? "", context),
                                controller: context
                                    .read<EditCouponCubit>()
                                    .codeTextController,
                                textInputAction: TextInputAction.next,
                              ),
                              buildSpacerH(10),
                              RoundedInputField(
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.number,
                                hintText: AText.discontrate.tr(context),
                                validator: (value) =>
                                    ManagerValidator.validateEmptyText(
                                        "Discount rate", value ?? "", context),
                                controller: context
                                    .read<EditCouponCubit>()
                                    .discountRateController,
                              ),
                              buildSpacerH(10.0),
                              RoundedInputField(
                                textInputAction: TextInputAction.done,
                                hintText: AText.enterYourLikeStore.tr(context),
                                controller: context
                                    .read<EditCouponCubit>()
                                    .storeLinkController,
                                validator: (value) =>
                                    ManagerValidator.validateURL(
                                        value ?? "", context),
                              ),
                              buildSpacerH(10),
                              BlocBuilder<EditCouponCubit, EditCouponState>(
                                buildWhen: (previous, current) =>
                                    current is CategoriesLoadedEditCoupon ||
                                    current is CategorySelectedEditCoupon,
                                builder: (context, state) {
                                  if (state is CategoriesLoadedEditCoupon) {
                               
                                    return SelectDropList(
                                      itemSelected: OptionItem(
                                          id: widget.coupon.categoryID, title: widget.coupon.category?.title["en"]),
                                      dropListModel:
                                          state.listOfCategoriesOption,
                                      onOptionSelected:
                                          (OptionItem optionItem) {
                                        context
                                            .read<EditCouponCubit>()
                                            .selectCategory(optionItem);
                                      },
                                    );
                                  }else if (state is CategorySelectedEditCoupon){
                                    return SelectDropList(
                                      itemSelected: state.optionItemSelected,
                                      dropListModel:
                                          context.read<EditCouponCubit>().listOfCategoriesOption,
                                      onOptionSelected:
                                          (OptionItem optionItem) {
                                        context
                                            .read<EditCouponCubit>()
                                            .selectCategory(optionItem);
                                      },
                                    );
                                  }
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                              buildSpacerH(10.0),
                              buildExpireDataWidget(context, selectedDate),
                              buildSpacerH(10.0),
                              AdditionalTermsCardWidget(controller:context.read<EditCouponCubit>().additionalTerms,),
                              buildSpacerH(20.0),
                              Column(
                                children: [
                                  RoundedButtonWgt(
                                    title: AText.save.tr(context),
                                    onPressed: () {
                                      validateThenEditCoupon(context);
                                    },
                                  ),
                                  buildSpacerH(10.0),
                                  RounderBorderCancelButton(),
                                ],
                              ),
                              BlocListener<EditCouponCubit, EditCouponState>(
                                listenWhen: (previous, current) =>
                                    current is LoadingEditCoupon ||
                                    current is SuccessEditCoupon,
                                listener: (context, state) {
                                  state.maybeMap(
                                      loadingEditCoupon: (value) =>
                                          Center(child: BuildCustomLoader()),
                                      successEditCoupon: (value) {
                                        TLoader.showSuccessSnackBar(context,
                                            title: "The coupon has been successfully updated.".tr(context));
                                            context.pop();                                                                                
                                      },
                                      orElse: () {});
                                },
                                child: SizedBox(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void validateThenEditCoupon(BuildContext context) {
    // if (context.read<EditCouponCubit>().formKey.currentState!.validate()) {
      // if (context.read<EditCouponCubit>().optionItemSelected?.id == null) {
      //   TLoader.showErrorSnackBar(context,
      //       title: "Required field".tr(context),
      //       message: "Please enter your store category.".tr(context));
      // }
      // if (context.read<EditCouponCubit>().dateItem == null) {
      //   TLoader.showErrorSnackBar(context,
      //       title: "Required field".tr(context),
      //       message: "Please select an expiration date.".tr(context));
      // }

    // }
          context.read<EditCouponCubit>().editCoupon(widget.coupon.couponId);

  }

  Widget buildImagePicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "Change the coupon logo".tr(context),
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
            ),
            SizedBox(height: 5.h),
            Text(
              "JPG or PNG or SVG\n(Max 128*128 pixels)".tr(context),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(width: 5),
        BlocBuilder<EditCouponCubit, EditCouponState>(
          buildWhen: (previous, current) =>
              current is LoadedSetLogoStoreEditCoupon ||
              current is LoadingSetLogoStoreEditCoupon ||
              current is CouponLoadedEditCoupon,
          builder: (context, state) {
            return state.maybeWhen(
              loadingSetLogoStoreEditCoupon: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loadedSetLogoStoreEditCoupon: (imageURL) => CircleAvatar(
                  radius: 40, backgroundImage: FileImage(File(imageURL.path))),
              couponLoadedEditCoupon: (coupon) {
                return Stack(
                  children: [
                    widget.coupon.storeLogoURL!.isEmpty
                        ? Container(
                            decoration: BoxDecoration(
                                color: ManagerColors.kCustomColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: LottieBuilder.asset(
                              LottieConstnts.emptyImageAnimation,
                              width: 100,
                              height: 100,
                            ))
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: CachedNetworkImageProvider(
                                widget.coupon.storeLogoURL!)),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => context
                            .read<EditCouponCubit>()
                            .editLogoForCouponPicture(widget.coupon.couponId),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: ManagerColors.kCustomColor,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              orElse: () => Stack(
                children: [
                  widget.coupon.storeLogoURL!.isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: ManagerColors.kCustomColor),
                          child: LottieBuilder.asset(
                            LottieConstnts.emptyImageAnimation,
                            width: 100,
                            height: 100,
                          ))
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: CachedNetworkImageProvider(
                              widget.coupon.storeLogoURL!)),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () => context
                          .read<EditCouponCubit>()
                          .editLogoForCouponPicture(widget.coupon.couponId),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: ManagerColors.kCustomColor,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  SizedBox buildExpireDataWidget(BuildContext context, DateTime? selectedDate) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: context.read<EditCouponCubit>().dateController,
        validator: (value) {
          if (value == null || value.isEmpty || pickedDate == null) {
            return "Please select an expiration date.".tr(context);
          }
          return null;
        },
        style: TextStyle(fontSize: 16.sp, color: Colors.black),
        decoration: InputDecoration(
          errorStyle: GoogleFonts.cairo(
              color: Colors.red, fontSize: 10.sp, fontWeight: FontWeight.bold),
          hintText: AText.exDate.tr(context),
          hintStyle:
              const TextStyle(color: ManagerColors.kCustomColor, fontSize: 16),
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(Icons.arrow_drop_down),
            onPressed: () async {
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
                          .read<EditCouponCubit>()
                          .selectDate(dateTime ?? DateTime.now());
                    },
                  );
                },
              );
            },
          ),
          fillColor: Colors.white,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
        ),
      ),
    );
  }
}
