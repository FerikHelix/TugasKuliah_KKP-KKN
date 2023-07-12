import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:si_kkp_kkn/constant/alert.dart';
import 'package:si_kkp_kkn/constant/buttonStyle.dart';
import 'package:si_kkp_kkn/constant/color.dart';
import 'package:si_kkp_kkn/constant/custom_toast.dart';
import 'package:si_kkp_kkn/constant/inputDecoration.dart';
import 'package:si_kkp_kkn/constant/textStyle.dart';

class ScreenDaftarKKP extends StatefulWidget {
  const ScreenDaftarKKP({super.key});

  @override
  State<ScreenDaftarKKP> createState() => _ScreenDaftarKKPState();
}

class _ScreenDaftarKKPState extends State<ScreenDaftarKKP> {
  bool isLoading = false;
  TextEditingController companyName = TextEditingController();
  TextEditingController companyAddress = TextEditingController();
  TextEditingController bidangKerja = TextEditingController();
  TextEditingController mentorInCompany = TextEditingController();
  TextEditingController waktuMulai = TextEditingController();
  TextEditingController waktuBerakhir = TextEditingController();

  String _formatDate(String date) {
    return date.replaceAll('00:00:00.000', '');
  }

  String _formatDate2(String date) {
    return date.replaceAll('00:00:00.000', '');
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
        title: Text(
          "Pendaftaran KKP",
          style: CustomTextStyle.heading
              .copyWith(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: CustomColor.white,
            height: size.height,
            width: size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.h),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Nama Perusahaan",
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
                        controller: companyName,
                        decoration: CustomInputDecoration.primary.copyWith(
                          hintText: "Masukkan nama perusahaan",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Alamat Perusahaan",
                      style: CustomTextStyle.heading.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      // height: 50.h,
                      decoration: BoxDecoration(
                        color: CustomColor.secondaryColor,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: TextFormField(
                        autofocus: false,
                        minLines: 1,
                        maxLines: 5,
                        controller: companyAddress,
                        decoration: CustomInputDecoration.primary.copyWith(
                          hintText: "Masukkan alamat perusahaan",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Bidang Kerja",
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
                        controller: bidangKerja,
                        decoration: CustomInputDecoration.primary.copyWith(
                          hintText: "Masukkan bidang kerja",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Pembimbing Lapangan",
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
                        controller: mentorInCompany,
                        decoration: CustomInputDecoration.primary.copyWith(
                          hintText: "Masukkan pembimbing lapangan",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Waktu Mulai",
                                style: CustomTextStyle.heading.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp),
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
                                  onTap: () async {
                                    var dateTime1 = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2023),
                                        lastDate: DateTime(2100));
                                    if (dateTime1 != null) {
                                      setState(() {
                                        waktuMulai.text =
                                            _formatDate2(dateTime1.toString());
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  autofocus: false,
                                  showCursor: false,
                                  controller: waktuMulai,
                                  decoration:
                                      CustomInputDecoration.primary.copyWith(
                                    hintText: "2023/01/26",
                                    suffixIcon: const Icon(
                                      Icons.calendar_month,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Waktu Berakhir",
                                style: CustomTextStyle.heading.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp),
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
                                  onTap: () async {
                                    var dateTime2 = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2023),
                                        lastDate: DateTime(2100));
                                    if (dateTime2 != null) {
                                      setState(() {
                                        waktuBerakhir.text =
                                            _formatDate(dateTime2.toString());
                                      });
                                    }
                                  },
                                  showCursor: false,
                                  autofocus: false,
                                  controller: waktuBerakhir,
                                  keyboardType: TextInputType.none,
                                  decoration:
                                      CustomInputDecoration.primary.copyWith(
                                    hintText: "2023/02/26",
                                    suffixIcon: const Icon(
                                      Icons.calendar_month,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (isLoading == false) {
                            if (companyName.text.isNotEmpty &&
                                companyAddress.text.isNotEmpty &&
                                bidangKerja.text.isNotEmpty &&
                                mentorInCompany.text.isNotEmpty &&
                                waktuMulai.text.isNotEmpty &&
                                waktuBerakhir.text.isNotEmpty) {
                              setState(() {
                                isLoading = true;
                              });
                              await FirebaseFirestore.instance
                                  .collection("registration-kkn-kkp")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                "iddoc": FirebaseAuth.instance.currentUser!.uid,
                                "namaPerusahaan": companyName.text,
                                "alamatPerusahaan": companyAddress.text,
                                "bidangKerja": bidangKerja.text,
                                "pembimbingLapangan": mentorInCompany.text,
                                "waktuMulai": waktuMulai.text,
                                "waktuBerakhir": waktuBerakhir.text,
                              });
                              // ignore: use_build_context_synchronously
                              MyCustomToast.successToast(
                                  context, "Berhasil mendaftar KKP");
                              setState(() {
                                isLoading = false;
                                companyName.clear();
                                companyAddress.clear();
                                bidangKerja.clear();
                                mentorInCompany.clear();
                                waktuMulai.clear();
                                waktuBerakhir.clear();
                              });
                            } else {
                              void callback() {
                                Navigator.of(context).pop();
                              }

                              Notifikasi.errorAlert(context,
                                  "Harap lengkapi semua form", callback);
                            }
                          } else {
                            null;
                          }
                        },
                        style: CustomButton.primaryButton,
                        child: isLoading == false
                            ? Text(
                                "Daftar KKP",
                                style: CustomTextStyle.heading
                                    .copyWith(color: CustomColor.black),
                              )
                            : CircularProgressIndicator(
                                color: CustomColor.white),
                      ),
                    ),
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
