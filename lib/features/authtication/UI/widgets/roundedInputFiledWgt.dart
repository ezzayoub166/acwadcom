

import 'package:acwadcom/acwadcom_packges.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final bool isSecure;
  final String? Function(String?)? validator; 
  final TextInputType? textInputType;// Add validator as a parameter

  const RoundedInputField({
    super.key,
    required this.hintText,
    
    this.isSecure = false, required this.validator, this.textInputType,
  });

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  bool hidePassword;  // Now a mutable state variable

  _RoundedInputFieldState() : hidePassword = true;  // Initialize in the constructor

  void toggleHidePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10), // Add some margin
      width: double.infinity,
      child: TextFormField(
        keyboardType: widget.textInputType ?? TextInputType.name,
        validator:widget.validator,
        obscureText: widget.isSecure ? hidePassword : false, // Control visibility
        style:  TextStyle(
          fontSize: 16.sp,
          color: Colors.black, // Text color
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          
          filled: true,
          suffixIcon: widget.isSecure
              ? IconButton(
                  icon: Icon(
                      hidePassword ? Iconsax.eye_slash :Iconsax.eye),
                  onPressed: toggleHidePassword,
                )
              : null,
          fillColor: Colors.white, // Background color of the input field
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
        ),
      ),
    );
  }
}