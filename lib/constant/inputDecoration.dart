import 'package:flutter/material.dart';
import 'package:si_kkp_kkn/constant/color.dart';

class CustomInputDecoration {
  static InputDecoration primary = InputDecoration(
    filled: true,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    hintStyle: TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: CustomColor.black),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(
        5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(
        5,
      ),
    ),
  );
}
