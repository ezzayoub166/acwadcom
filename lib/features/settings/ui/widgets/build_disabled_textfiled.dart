// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors


import 'package:acwadcom/acwadcom_packges.dart';

Widget buildDisabledTextField({required String text}){
  return Container(
            width: 300.h,
            child: TextField(
              enabled: false, // لتعطيل TextField
              decoration: InputDecoration(
                hintText: text, // النص المعروض
                hintStyle: TextStyle(
                  color: Colors.black54, // لون النص
                  fontWeight: FontWeight.bold, // نمط الخط
                ),
                filled: true,
                fillColor: Colors.grey[100], // لون الخلفية
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // شكل الحواف الدائرية
                  borderSide: BorderSide(
                    color: Colors.grey, // لون الحدود
                    width: 1.0, // عرض الحدود
                  ),
                ),
              )));
}