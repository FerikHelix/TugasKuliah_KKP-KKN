import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:si_kkp_kkn/constant/alert.dart';
import 'package:si_kkp_kkn/constant/buttonStyle.dart';
import 'package:si_kkp_kkn/constant/color.dart';
import 'package:si_kkp_kkn/constant/custom_toast.dart';
import 'package:si_kkp_kkn/constant/inputDecoration.dart';
import 'package:si_kkp_kkn/constant/textStyle.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool ceking = false;
  bool isLoading = false;
  String dospem = "";
  String filePdf = "";
  String pdfDrDB = "";
  String? fileName;
  File? file;

  TextEditingController komentar = TextEditingController();
  TextEditingController nilai = TextEditingController();

  _pickFileAndUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      fileName = result.files.single.name;
      file = File(result.files.single.path!);
      setState(() {});
    }
  }

  void fungsiDrdb() async {
    await FirebaseFirestore.instance
        .collection("daftar-kkn-kkp")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        ceking = value.exists;
        dospem = value.data()!['dospem'];
        filePdf = value.data()!['pdf'];
        pdfDrDB = value.data()!['pdfName'];
        if (value.data()!['nilai'] == null) {
          nilai.text = "-";
        } else {
          nilai.text = value.data()!['nilai'].toString();
        }
        if (value.data()!['komentar'] == null) {
          komentar.text = "-";
        } else {
          komentar.text = value.data()!['komentar'].toString();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fungsiDrdb();
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
          "Laporan",
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
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 30.h),
              child: dospem == ""
                  ? Padding(
                      padding: const EdgeInsets.only(top: 250.0),
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error_rounded,
                              color: Colors.red,
                              size: 60.sp,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(
                              "Anda belum memiliki dosen pembimbing",
                              textAlign: TextAlign.center,
                              style: CustomTextStyle.heading.copyWith(
                                  color: CustomColor.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    )
                  : ceking != false
                      ? Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Upload File",
                                style: CustomTextStyle.heading.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                height: 50.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: CustomColor.secondaryColor,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: pdfDrDB != ""
                                            ? Text(
                                                pdfDrDB,
                                                style: TextStyle(
                                                    color: CustomColor.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : fileName == null
                                                ? Text(
                                                    "Choose File",
                                                    style: TextStyle(
                                                        color:
                                                            CustomColor.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                : Text(
                                                    fileName.toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            CustomColor.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        calback() {
                                          Navigator.of(context).pop();
                                        }

                                        if (pdfDrDB == "") {
                                          await _pickFileAndUpload();
                                        } else {
                                          Notifikasi.questionAlert(
                                              context,
                                              "Perbarui laporan yang sudah ada?",
                                              calback,
                                              _pickFileAndUpload);
                                        }
                                      },
                                      child: Container(
                                        width: 110.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5.r),
                                            bottomRight: Radius.circular(5.r),
                                            topLeft: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Browse",
                                            style: TextStyle(
                                                color: CustomColor.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "Komentar",
                                style: CustomTextStyle.heading.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                height: 100.h,
                                decoration: BoxDecoration(
                                  color: CustomColor.secondaryColor,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: TextFormField(
                                  readOnly: true,
                                  keyboardType: TextInputType.none,
                                  autofocus: false,
                                  minLines: 5,
                                  maxLines: 5,
                                  controller: komentar,
                                  decoration:
                                      CustomInputDecoration.primary.copyWith(),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "Nilai",
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
                                  readOnly: true,
                                  keyboardType: TextInputType.none,
                                  autofocus: false,
                                  controller: nilai,
                                  decoration:
                                      CustomInputDecoration.primary.copyWith(),
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
                                    if (isLoading == false) {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      if (fileName != null || file != null) {
                                        var reference = FirebaseStorage.instance
                                            .ref()
                                            .child('allFiles')
                                            .child(fileName!);

                                        try {
                                          reference.putFile(file!);
                                          //Success: get the download URL
                                          String url =
                                              await reference.getDownloadURL();

                                          debugPrint(url);

                                          if (url.isNotEmpty) {
                                            FirebaseFirestore.instance
                                                .collection("daftar-kkn-kkp")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .update({
                                              "pdf": url,
                                              "pdfName": fileName
                                            });
                                            // ignore: use_build_context_synchronously
                                            MyCustomToast.successToast(context,
                                                "Berhasil mengirim laporan");
                                            setState(() {
                                              fileName = null;
                                              file == null;
                                              isLoading = false;
                                            });
                                            fungsiDrdb();
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        } on FirebaseException catch (_) {
                                          // ignore: use_build_context_synchronously
                                          MyCustomToast.errorToast(context,
                                              "Gagal mengirim laporan");
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      } else {
                                        MyCustomToast.errorToast(
                                            context, "Anda belum memilih file");
                                      }
                                    } else {}
                                  },
                                  style: CustomButton.primaryButton,
                                  child: isLoading == false
                                      ? Text(
                                          "Kirim Laporan",
                                          style: CustomTextStyle.heading
                                              .copyWith(
                                                  color: CustomColor.black),
                                        )
                                      : CircularProgressIndicator(
                                          color: CustomColor.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 250.0),
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.error_rounded,
                                  color: Colors.red,
                                  size: 60.sp,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  "Anda Belum Terdaftar di KKP/KKN",
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyle.heading.copyWith(
                                      color: CustomColor.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
