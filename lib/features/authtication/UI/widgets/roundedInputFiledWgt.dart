import 'package:acwadcom/acwadcom_packges.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final bool isSecure;
  final String? Function(String?)? validator; 
  final TextInputType? textInputType;
  final TextEditingController? controller;

  const RoundedInputField({
    super.key,
    required this.hintText,
    this.isSecure = false, 
    required this.validator, 
    this.textInputType,  
    this.controller,
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
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.textInputType ?? TextInputType.name,
            validator: widget.validator,
            obscureText: widget.isSecure ? hidePassword : false,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black, // Text color
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              filled: true,
              suffixIcon: widget.isSecure
                  ? IconButton(
                      icon: Icon(hidePassword ? Iconsax.eye_slash : Iconsax.eye),
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
                fontSize: 12.sp,
                fontWeight: FontWeight.bold // Error text font size
              ),
            ),
          ),
          // Add spacing if you need space between input and error text
        ],
      ),
    );
  }
}