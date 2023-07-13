import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:si_kkp_kkn/constant/color.dart';

class Notifikasi {
  static void loading(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Dialog(
              elevation: 0,
              backgroundColor: CustomColor.secondaryColor,
              child: SizedBox(
                width: 170,
                height: 170,
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/loading2.json',
                    width: 170,
                    height: 170,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
        });
  }

  static void warningAlert(
      BuildContext context, String text, Function callback) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0.r),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 10.0.h),
          content: SizedBox(
            width: 170.w,
            height: 325.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/warning_alert.json',
                  width: 130,
                  height: 130,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.black),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                            side: BorderSide(
                                width: 1.2.w,
                                color: CustomColor.secondaryColor),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            CustomColor.secondaryColor),
                      ),
                      onPressed: () {
                        callback();
                      },
                      child: Text(
                        "Close",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void questionAlert(BuildContext context, String text,
      Function callback, VoidCallback callback2) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0.r),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 10.0.h),
          content: SizedBox(
            width: 170.w,
            height: 325.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/warning_alert.json',
                  width: 130,
                  height: 130,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.black),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 55.h,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0.r),
                                  side: BorderSide(
                                      width: 1.2.w,
                                      color: CustomColor.secondaryColor),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  CustomColor.secondaryColor),
                            ),
                            onPressed: () {
                              callback();
                            },
                            child: Text(
                              "Tidak",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColor.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 55.h,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0.r),
                                  side: BorderSide(
                                      width: 1.2.w,
                                      color: CustomColor.secondaryColor),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  CustomColor.primaryColor),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                              callback2();
                            },
                            child: Text(
                              "Ya",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColor.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void successAlert(
      BuildContext context, String text, Function callback) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0.r),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 10.0.h),
          content: SizedBox(
            width: 170.w,
            height: 325.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/success_alert_fix.json',
                  width: 130,
                  height: 130,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.black),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                            side: BorderSide(
                                width: 1.2.w,
                                color: CustomColor.secondaryColor),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            CustomColor.secondaryColor),
                      ),
                      onPressed: () {
                        callback();
                      },
                      child: Text(
                        "Close",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void successAlertSignUP(
      BuildContext context, String text, Function callback) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0.r),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 10.0.h),
          content: SizedBox(
            width: 170.w,
            height: 325.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/success_alert_fix.json',
                  width: 130,
                  height: 130,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.black),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                            side: BorderSide(
                                width: 1.2.w, color: CustomColor.white),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            CustomColor.secondaryColor),
                      ),
                      onPressed: () {
                        callback();
                      },
                      child: Text(
                        "OK",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void errorAlert(BuildContext context, String text, Function callback) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0.r),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 10.0.h),
          content: SizedBox(
            width: 170.w,
            height: 325.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/eror_alert.json',
                  width: 130,
                  height: 130,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.black),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                            side: BorderSide(
                                width: 1.2.w,
                                color: CustomColor.secondaryColor),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            CustomColor.secondaryColor),
                      ),
                      onPressed: () {
                        callback();
                      },
                      child: Text(
                        "Close",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
