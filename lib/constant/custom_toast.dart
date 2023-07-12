import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCustomToast {
  static successToast(BuildContext context, String text) {
    return CherryToast.success(
            title: Text(
              "",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
            displayTitle: false,
            description: Text(
              text,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
            animationType: AnimationType.fromTop,
            toastDuration: const Duration(milliseconds: 1500),
            animationDuration: const Duration(milliseconds: 500),
            autoDismiss: true)
        .show(context);
  }

  static errorToast(BuildContext context, String text) {
    return CherryToast.error(
            title: Text(
              "",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
            displayTitle: false,
            description: Text(
              text,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
            animationType: AnimationType.fromTop,
            toastDuration: const Duration(milliseconds: 1500),
            animationDuration: const Duration(milliseconds: 500),
            autoDismiss: true)
        .show(context);
  }
}
