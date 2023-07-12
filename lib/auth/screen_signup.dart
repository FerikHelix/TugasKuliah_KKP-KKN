import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:si_kkp_kkn/constant/alert.dart';
import 'package:si_kkp_kkn/constant/buttonStyle.dart';
import 'package:si_kkp_kkn/constant/color.dart';
import 'package:si_kkp_kkn/constant/extensionCapitalize.dart';
import 'package:si_kkp_kkn/constant/inputDecoration.dart';
import 'package:si_kkp_kkn/constant/textStyle.dart';
import 'package:intl/intl.dart';

class ScreenSignup extends StatefulWidget {
  const ScreenSignup({super.key});

  @override
  State<ScreenSignup> createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup> {
  bool isLoading = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  TextEditingController nim = TextEditingController();
  bool isObscure1 = true;
  bool isObscure2 = true;
  String role = "mahasiswa";

  Future signUp() async {
    if (passwordConfirmed()) {
      if (email.text.isNotEmpty && name.text.isNotEmpty) {
        // create user
        try {
          UserCredential userCredentialCustomer =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );

          if (userCredentialCustomer.user != null) {
            String uid = userCredentialCustomer.user!.uid;

            FirebaseFirestore.instance.collection('users').doc(uid).set({
              'namaLengkap': name.text,
              'email': email.text,
              'nim': nim.text,
              'uid': uid,
              'role': role,
              'createdAt': DateFormat('yyyy-MM-dd HH:mm:ss').format(
                DateTime.now(),
              ),
            });

            name.clear();
            email.clear();
            nim.clear();
            password.clear();
            confirmPassword.clear();

            // alert berhasil add pegawai
            void callback() {
              Navigator.of(context).pop();
            }

            // ignore: use_build_context_synchronously
            Notifikasi.successAlertSignUP(
                context, "Akun telah berhasil dibuat", callback);
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            void callback() {
              Navigator.of(context).pop();
            }

            // ignore: use_build_context_synchronously
            Notifikasi.warningAlert(
                context, "Password minimal 6 karakter", callback);
          } else if (e.code == 'email-already-in-use') {
            void callback() {
              Navigator.of(context).pop();
            }

            // ignore: use_build_context_synchronously
            Notifikasi.errorAlert(context, 'Email sudah terdaftar!', callback);
          } else {
            void callback() {
              Navigator.of(context).pop();
            }

            // ignore: use_build_context_synchronously
            Notifikasi.errorAlert(context, e.code.toString(), callback);
          }
        }
      } else {
        void callback() {
          Navigator.of(context).pop();
        }

        // ignore: use_build_context_synchronously
        Notifikasi.errorAlert(
            context, 'Harap lengkapi semua data dengan benar!', callback);
      }
    } else {
      void callback() {
        Navigator.of(context).pop();
      }

      // ignore: use_build_context_synchronously
      Notifikasi.errorAlert(context, 'Confirm password kamu salah!', callback);
    }
  }

  bool passwordConfirmed() {
    if (password.text.trim() == confirmPassword.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.white,
        elevation: 0,
        leadingWidth: 30,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 24.sp,
            color: CustomColor.black,
          ),
        ),
        title: Row(
          children: [
            SizedBox(
              height: 35.h,
              width: 35.h,
              child: Image.asset("assets/images/logo.png"),
            ),
            SizedBox(
              width: 6.h,
            ),
            Text(
              "Global Institute",
              style: CustomTextStyle.heading
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 18.sp),
            ),
          ],
        ),
      ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Buat Akun",
                      style: CustomTextStyle.heading.copyWith(
                          fontWeight: FontWeight.w700, fontSize: 24.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Please input with correct data.",
                      style: CustomTextStyle.heading.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Text(
                      "Name",
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
                        controller: name,
                        decoration: CustomInputDecoration.primary
                            .copyWith(hintText: "Please input your name"),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: CustomInputDecoration.primary
                            .copyWith(hintText: "Please input your email"),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "NIM",
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
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        controller: nim,
                        decoration: CustomInputDecoration.primary
                            .copyWith(hintText: "Please input your NIM"),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Role",
                      style: CustomTextStyle.heading.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: CustomColor.secondaryColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: role,
                        onChanged: (String? newValue) {
                          setState(() {
                            role = newValue!;
                          });
                        },
                        dropdownColor: CustomColor.secondaryColor,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: CustomColor.black,
                        ),
                        style: TextStyle(
                          color: CustomColor.black,
                          fontSize: 16.0,
                        ),
                        underline: Container(),
                        items: <String>[
                          'mahasiswa',
                          'kaprodi',
                          'dospem',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
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
                        obscureText: isObscure1,
                        decoration: CustomInputDecoration.primary.copyWith(
                            hintText: "Please input your password",
                            suffixIcon: isObscure1 == false
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isObscure1 = !isObscure1;
                                      });
                                    },
                                    child: const Icon(Icons.remove_red_eye))
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isObscure1 = !isObscure1;
                                      });
                                    },
                                    child: const Icon(Icons.visibility_off))),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Confirm Password",
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
                        controller: confirmPassword,
                        obscureText: isObscure2,
                        decoration: CustomInputDecoration.primary.copyWith(
                            hintText: "Please input password again",
                            suffixIcon: isObscure2 == false
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isObscure2 = !isObscure2;
                                      });
                                    },
                                    child: const Icon(Icons.remove_red_eye))
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isObscure2 = !isObscure2;
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
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await signUp();
                          setState(() {
                            isLoading = false;
                          });
                        },
                        style: CustomButton.primaryButton,
                        child: isLoading == false
                            ? Text(
                                "Buat Akun",
                                style: CustomTextStyle.heading
                                    .copyWith(color: CustomColor.black),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                    color: CustomColor.white),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Have account?",
                    //       style: CustomTextStyle.paraghraph,
                    //     ),
                    //     TextButton(
                    //       onPressed: () {
                    //         Navigator.of(context).push(
                    //           MaterialPageRoute(
                    //               builder: (context) => const ScreenLogin()),
                    //         );
                    //       },
                    //       child: Text(
                    //         "Login",
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
