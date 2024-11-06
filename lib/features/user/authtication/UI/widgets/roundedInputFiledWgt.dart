import 'package:acwadcom/acwadcom_packges.dart';
import 'package:intl/intl.dart' as intl;


class RoundedInputField extends StatefulWidget {
  final String hintText;
  final bool isSecure;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final BuildContext? context;
  final TextInputAction? textInputAction;
  final bool isFromLeftForLoginInput ;

  const RoundedInputField(
      {super.key,
      required this.hintText,
      this.isSecure = false,
      this.isFromLeftForLoginInput = false,
      required this.validator,
      this.textInputType,
      this.controller,
      this.context,
      this.textInputAction});

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  bool hidePassword; // Now a mutable state variable

  _RoundedInputFieldState()
      : hidePassword = true; // Initialize in the constructor

  void toggleHidePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = intl.Bidi.detectRtlDirectionality("some text");

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            textAlign: TextAlign.center,
            textInputAction: widget.textInputAction ?? TextInputAction.done,
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
                      icon:
                          Icon(hidePassword ? Iconsax.eye_slash : Iconsax.eye),
                      onPressed: toggleHidePassword,
                    )
                  : null,
              fillColor: Colors.white, // Background color of the input field
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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

  TextDirection getDirection(String v) {
  final string = v.trim();
  if (string.isEmpty) return TextDirection.ltr;
  final firstUnit = string.codeUnitAt(0);
  if (firstUnit > 0x0600 && firstUnit < 0x06FF ||
      firstUnit > 0x0750 && firstUnit < 0x077F ||
      firstUnit > 0x07C0 && firstUnit < 0x07EA ||
      firstUnit > 0x0840 && firstUnit < 0x085B ||
      firstUnit > 0x08A0 && firstUnit < 0x08B4 ||
      firstUnit > 0x08E3 && firstUnit < 0x08FF ||
      firstUnit > 0xFB50 && firstUnit < 0xFBB1 ||
      firstUnit > 0xFBD3 && firstUnit < 0xFD3D ||
      firstUnit > 0xFD50 && firstUnit < 0xFD8F ||
      firstUnit > 0xFD92 && firstUnit < 0xFDC7 ||
      firstUnit > 0xFDF0 && firstUnit < 0xFDFC ||
      firstUnit > 0xFE70 && firstUnit < 0xFE74 ||
      firstUnit > 0xFE76 && firstUnit < 0xFEFC ||
      firstUnit > 0x10800 && firstUnit < 0x10805 ||
      firstUnit > 0x1B000 && firstUnit < 0x1B0FF ||
      firstUnit > 0x1D165 && firstUnit < 0x1D169 ||
      firstUnit > 0x1D16D && firstUnit < 0x1D172 ||
      firstUnit > 0x1D17B && firstUnit < 0x1D182 ||
      firstUnit > 0x1D185 && firstUnit < 0x1D18B ||
      firstUnit > 0x1D1AA && firstUnit < 0x1D1AD ||
      firstUnit > 0x1D242 && firstUnit < 0x1D244) {
    return TextDirection.rtl;
  }
  return TextDirection.ltr;
}
}
