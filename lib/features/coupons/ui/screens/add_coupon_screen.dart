import 'package:acwadcom/acwadcom_packges.dart';

class CreateCodeScreen extends StatefulWidget {
  const CreateCodeScreen({super.key});

  @override
  State<CreateCodeScreen> createState() => _CreateCodeScreenState();
}

class _CreateCodeScreenState extends State<CreateCodeScreen> {
  DateTime? pickedDate;
  bool isDateSelected = false; // To track if a date has been selected
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
    // OptionItem optionItemSelected =
    //     OptionItem(id: null, title: AText.choseTheCategory.tr(context));
    return Scaffold(
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
              builder: (context, state) {
                OptionItem? optionItemSelected;
                DateTime? selectedDate;

                // !! check if category is Selected
                if (state is CategorySelected) {
                  optionItemSelected = state.optionItemSelected;
                  // print(state);
                }

                if (state is DateSelected) {
                  selectedDate = state.selectedDate;
                  _dateController.text =
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
                              validator: (value) =>
                                  ManagerValidator.validateURL(
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
                                  .read<CreateCouponCubit>()
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
                  ),
                ));
              },
            )
          ]),
    );
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
