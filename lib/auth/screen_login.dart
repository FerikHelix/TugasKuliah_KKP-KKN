import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:si_kkp_kkn/auth/screen_signup.dart';
import 'package:si_kkp_kkn/constant/alert.dart';
import 'package:si_kkp_kkn/constant/buttonStyle.dart';
import 'package:si_kkp_kkn/constant/color.dart';
import 'package:si_kkp_kkn/constant/inputDecoration.dart';
import 'package:si_kkp_kkn/constant/textStyle.dart';
import 'package:si_kkp_kkn/screen/screen_dashboard.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isObscure = true;

  Future signIn() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      // waiting alert(done)
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 0.0),
          content: SizedBox(
            height: 60.h,
            width: 300.w,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: CircularProgressIndicator(
                        color: CustomColor.primaryColor),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(
                    'Mohon tunggu sebentar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      try {
        await FirebaseAuth.instance.signOut();
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );

        if (userCredential.user != null) {
          // untuk menutup loading
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const ScreenDashboard(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // untuk menutup loading
          Navigator.of(context).pop();
          // email tidak terdaftar(done)
          void callback() {
            Navigator.of(context).pop();
          }

          Notifikasi.errorAlert(
              context, "Email yang anda masukkan tidak terdaftar", callback);
        } else if (e.code == 'wrong-password') {
          // untuk menutup loading
          Navigator.of(context).pop();
          // password salah(done)
          void callback() {
            Navigator.of(context).pop();
          }

          Notifikasi.errorAlert(
              context, "Password yang anda masukkan salah", callback);
        } else if (e.code == 'invalid-email') {
          // untuk menutup loading
          Navigator.of(context).pop();
          // email tidak sesuai(done)
          void callback() {
            Navigator.of(context).pop();
          }

          Notifikasi.errorAlert(
              context, "Email yang anda masukkan tidak sesuai", callback);
        } else {
          // untuk menutup loading
          Navigator.of(context).pop();
          // e eror
          void callback() {
            Navigator.of(context).pop();
          }

          Notifikasi.errorAlert(context, e.code.toString(), callback);
        }
      }
    } else {
      void callback() {
        Navigator.of(context).pop();
      }

      Notifikasi.errorAlert(
          context, "Email dan Password tidak boleh kosong", callback);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: CustomColor.white,
            height: size.height,
            width: size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 25.h),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 150.h,
                        width: 150.h,
                        child: Image.asset("assets/images/logo.png"),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Text(
                        "Global Institute",
                        style: CustomTextStyle.heading.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 24.sp),
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Text(
                      "Email",
                      style: CustomTextStyle.heading.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: CustomColor.secondaryColor,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: TextFormField(
                        autofocus: false,
                        controller: email,
                        decoration: CustomInputDecoration.primary
                            .copyWith(hintText: "Please input your email"),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Password",
                      style: CustomTextStyle.heading.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: CustomColor.secondaryColor,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: TextFormField(
                        autofocus: false,
                        controller: password,
                        obscureText: isObscure,
                        decoration: CustomInputDecoration.primary.copyWith(
                            hintText: "Please input your password",
                            suffixIcon: isObscure == false
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    child: const Icon(Icons.remove_red_eye))
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    child: const Icon(Icons.visibility_off))),
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          signIn();
                        },
                        style: CustomButton.primaryButton,
                        child: Text(
                          "Login",
                          style: CustomTextStyle.heading
                              .copyWith(color: CustomColor.black),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 3.h,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Don't have an account yet?",
                    //       style: CustomTextStyle.paraghraph,
                    //     ),
                    //     TextButton(
                    //       onPressed: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const ScreenSignup()),
                    //         );
                    //       },
                    //       child: Text(
                    //         "Sign up now",
                    //         style: CustomTextStyle.paraghraph
                    //             .copyWith(fontWeight: FontWeight.w700),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
