import 'package:acwadcom/acwadcom_packges.dart';
import 'package:intl_phone_number_input_v2/intl_phone_number_input.dart';

class CustomPhoneNumberInput extends StatelessWidget {
  final TextEditingController controller;

  const CustomPhoneNumberInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
            data: Theme.of(context).copyWith(
              
        // Set the background color of the bottom sheet
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.red, // Change to your desired color
        )),
            
      child: InternationalPhoneNumberInput(
        maxLength: 9,
      
        onInputChanged: (PhoneNumber number) async {},
        onInputValidated: (bool value) {
          print(value);
        },
        spaceBetweenSelectorAndTextField:2,
        validator: (p0) =>
            ManagerValidator.validatePhoneNumber(p0, context: context),
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      
          useEmoji: true,
          setSelectorButtonAsPrefixIcon:
              false, // Removes the dropdown arrow if desired
          showFlags: true, // Set to false to hide the flag
      
          useBottomSheetSafeArea: true,
        ),
        ignoreBlank: false,
        
        autoValidateMode: AutovalidateMode.disabled,
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black, // Text color
        ),
        selectorTextStyle: const TextStyle(
          color: Colors.black,
        ),
        initialValue: PhoneNumber(isoCode: 'SA'),
        textFieldController: controller,
        
      
        formatInput: false,
        keyboardType: TextInputType.phone,
        // const TextInputType.numberWithOptions(
        //   signed: fa,
        //   decimal: true,
        // ),
        inputDecoration: InputDecoration(
          hintText: "53 222 4241",
          filled: true,
          fillColor: Colors.white,
           // Background color of the input field
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // Circular border
            borderSide: const BorderSide(
              color: Colors.transparent, // No border color
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // Circular border
            borderSide: const BorderSide(
              color: Colors.transparent, // No border color
              width: 0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.transparent, // No border color on error
              width: 0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.transparent, // No border color on focused error
              width: 0,
            ),
          ),
          errorStyle: TextStyle(
            color: Colors.red, // Change error message text color
            fontSize: 12,
            fontWeight: FontWeight.bold, // Error text font size
          ),
        ),
        inputBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        onSaved: (PhoneNumber number) async {
          // Get the formatted phone number with the country code
          PhoneNumber formattedNumber =
              await PhoneNumber.getRegionInfoFromPhoneNumber(
                  number.phoneNumber ?? "", number.dialCode ?? "+966");
      
          controller.text = formattedNumber.phoneNumber!;
        },
      ),
    );
  }
}
