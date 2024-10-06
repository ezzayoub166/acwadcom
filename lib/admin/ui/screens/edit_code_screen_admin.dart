import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/admin/logic/edit_screen/cubit/edit_code_cubit.dart';
import 'package:acwadcom/features/coupons/ui/widgets/build_app_bar_with_back_button.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables

class EditCodeScreenAdmin extends StatefulWidget {
  @override
  State<EditCodeScreenAdmin> createState() => _EditCodeScreenAdminState();
}

class _EditCodeScreenAdminState extends State<EditCodeScreenAdmin> {
  DateTime? pickedDate;

  bool isDateSelected = false;
  // To track if a date has been selected
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    //! To Pass it to State ..
    final translatedCategoryTitle = AText.choseTheCategory.tr(context);

    _dateController.text = translatedCategoryTitle;
    // Do the translation here

    DropListModel dropListModel = DropListModel([
      OptionItem(id: "1", title: "Option 1"),
      OptionItem(id: "2", title: "Option 2")
    ]);
    return Scaffold(
        appBar: buildAppBarWithBackButton(context, isRTL(context),
            title: AText.detilsDiscount.tr(context)),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
            child: BlocBuilder<EditCodeCubit, EditCodeState>(
                builder: (context, state) {
              OptionItem? optionItemSelected;
              DateTime? selectedDate;

              // !! check if category is Selected
              if (state is CategoryEdit) {
                optionItemSelected = state.optionItemSelectedEdit;
                // print(state);
              }

              if (state is DateEdit) {
                selectedDate = state.selectedDateEdit;
                _dateController.text =
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
              }
              return ListView(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://www.robotbutt.com/wp-content/uploads/2016/02/goodwill-logo.jpg",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                  myText(
                    "Edit Coupon".tr(context),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ManagerColors.kCustomColor,
                  ),
                  buildSpacerH(20.0),
                  Column(
                    children: [
                      RoundedInputField(
                          hintText: "Code herer..".tr(context),
                          validator: (value) =>
                              ManagerValidator.validateEmptyText(
                                  "Code", value ?? "")),
                      buildSpacerH(10),
                      RoundedInputField(
                          hintText: AText.discontrate.tr(context),
                          validator: (value) =>
                              ManagerValidator.validateEmptyText(
                                  "Discount rate", value ?? "")),

                      buildSpacerH(10.0),
                      RoundedInputField(
                          hintText: AText.enterYourLikeStore.tr(context),
                          validator: (value) => ManagerValidator.validateURL(
                              value ?? "", context)),
                      buildSpacerH(10),
                      //**Category Choose */
                      // Category selection drop down

                      SelectDropList(
                        itemSelected: OptionItem(
                            id: null, title: translatedCategoryTitle),
                        dropListModel: dropListModel,
                        onOptionSelected: (OptionItem optionItem) {
                          //** TOD Set State .... */
                          context
                              .read<EditCodeCubit>()
                              .selectCategory(optionItem);
                          // setState(() {
                          //   optionItemSelected = optionItem;
                          // });
                        },
                      ),
                      buildSpacerH(10.0),
                      // myText(AText.exDate.tr(context) ,  fontSize: 16 , color: ManagerColors.kCustomColor , fontWeight: FontWeightEnum.Bold.fontWeight),
                      buildExpireDataWidget(context, selectedDate),
                      buildSpacerH(10.0),
                      RoundedInputField(
                          textInputType: TextInputType.number,
                          hintText: AText.numberOfuse.tr(context),
                          validator: (value) =>
                              ManagerValidator.validateNumberOfUser(
                                  value ?? "", context)),
                      buildSpacerH(10.0),
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
                                navigateAndFinishNamed(
                                    context, Routes.revisonResponseScreen);
                              }),
                          buildSpacerH(10.0),
                          RounderBorderCancelButton()
                        ],
                      )
                    ],
                  ),
                ],
              );
            })));
  }

    SizedBox buildExpireDataWidget(BuildContext context, DateTime? selectedDate) {
    return SizedBox(
        width: double.infinity,
        child: TextFormField(
          
          controller: _dateController,
          enabled: !isDateSelected, // Disable when a date is selected
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
                                  .read<EditCodeCubit>()
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
