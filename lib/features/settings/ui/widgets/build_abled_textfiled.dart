import 'package:acwadcom/acwadcom_packges.dart';

Widget buildAbleTextField({
  required String text, // النص الافتراضي الذي سيتم عرضه
  required String? Function(String?)? validator, // الدالة للتحقق من صحة المدخلات
}) {
  return SizedBox(
    width: 300.w,
    height: 50.h,
    child: TextFormField(
      style: TextStyle(
          color: ManagerColors.kCustomColor,
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),
    
      initialValue: text, // النص المعروض في البداية
      validator: validator, // دالة التحقق من صحة المدخلات
      decoration: InputDecoration(        
        hintText: 'Enter text here', // نص المساعدة
        hintStyle: TextStyle(
          color: Colors.black54, // لون نص المساعدة
          fontWeight: FontWeight.bold, // نمط الخط
        ),
        filled: true,
        fillColor: Colors.grey[100], // لون الخلفية
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(39.0),
          borderSide: BorderSide(
            color: ManagerColors.kCustomColor,
            width: 1.0
          )
        ),
        
        enabledBorder: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(30.0), // شكل الحواف الدائرية
          borderSide: BorderSide(
            color: Colors.grey, // لون الحدود
            width: 1.0, // عرض الحدود
          ),
        ),
      ),
    ),
  );
}