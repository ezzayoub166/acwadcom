

import 'package:acwadcom/acwadcom_packges.dart';

class ManagerValidator {

  ///Empty Text Validation
  static String? validateEmptyText(String? filedName , String value){
    if(value == null || value.isEmpty){
      return '$filedName is required';
    }
    return null;
  }

  static String? validateEmail(String? value,BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Email is required.'.tr(context);
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.'.tr(context);
    }

    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "Password is required.".tr(context);
    }

    // Check for minimum password length
    if (value.length < 6) {
      return "Password must be at least 6 characters long.".tr(context);
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter.".tr(context);
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number.".tr(context);
    }

    // // Check for special characters
    // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return "Password must contain at least one special character.";
    // }

    return null;
  }

  static String? validatePhoneNumber(String? value,{required BuildContext context}) {
    if (value == null || value.isEmpty) {
      return "Phone number is required.".tr(context);
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).'; // 972 59 266 19 15
    }

    return null;
  }
  static String? validateURL(String? value , context){

 if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    bool validURL = Uri.parse(value).isAbsolute;
    if(validURL = false){
       return "Please enter a valid link.".tr(context);
    }

    return null;
  }


  static String? validateNumberOfUser(String value , context){
    if(value == null || value.isEmpty ){
      return "${AText.numberOfuse.tr(context)} is required";
    }
    int number = int.parse(value);

    if(number > 100){
      return "The number of uses ranges from 20 to 100.".tr(context);
    }

    return null;

  }

// Add more custom validators as needed for your specific requirements.
}
