import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  String? label,
  bool isPassword = false,
  bool isClickable = true,
  int? maxLength,
  double height = 44,
  double? width, // Added width parameter

  void Function(String)? onSubmit,
  void Function(String)? onChanged,
  void Function()? onTap,
  String? Function(String?)? validator,
  IconData? prefix,
  IconData? suffix,
  void Function()? suffixPressed,
}) =>
     Container(
      width: width, // Set the width of the container
      child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        cursorColor: Colors.black,
        onFieldSubmitted: onSubmit,
        onChanged: onChanged,
        onTap: onTap,
        style: const TextStyle(color: Colors.black),
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: label,
          prefixIcon: prefix != null
              ? Icon(
            prefix,
            color: Colors.black54,
          )
              : null,
          suffixIcon: suffix != null
              ? IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
              color: Colors.black54,
            ),
          )
              : null,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,

            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          contentPadding: prefix != null ? null : EdgeInsets.only(left: 15.0.w),
          labelStyle: TextStyle(
            color: Colors.black54,
            fontSize: 14.sp
          ),
        ),
      ),
    );

final Color myColor = HexColor('#110E47');

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
  Icon? icon, // Optional icon
}) =>
    Container(
      width: width,
      height: 42.0.h,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) icon,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                 text,
                style: const TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'WorkSans'
                ),
                maxLines: 2, // Allow text to wrap into two lines
                overflow: TextOverflow.ellipsis, // Handle long text with an ellipsis
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );
