import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:si_kkp_kkn/constant/color.dart';

class CustomButton {
  static ButtonStyle primaryButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(CustomColor.primaryColor),
    elevation: MaterialStateProperty.all(0),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(width: 1.2.w, color: CustomColor.primaryColor),
      ),
    ),
  );
  static ButtonStyle secondaryButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(CustomColor.white),
    elevation: MaterialStateProperty.all(0),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(width: 1.2.w, color: CustomColor.primaryColor),
      ),
    ),
  );
}
