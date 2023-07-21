import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
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
  final List<File> _images = [];
  List lampiran = [];
  String uploadProgress = "0%";

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

  upload() async {
    if (fileName != null || file != null || _images.isNotEmpty) {
      List<String> downloadUrl = <String>[];
      PickedFile? pickedFile;
      for (int i = 0; i < _images.length; i++) {
        file = File(_images[i].path);
        pickedFile = PickedFile(file!.path);

        String nama = DateTime.now().millisecondsSinceEpoch.toString();

        Reference reference =
            FirebaseStorage.instance.ref().child('lampiran').child(nama);
        await reference.putData(
          await pickedFile.readAsBytes(),
          SettableMetadata(contentType: 'image/jpeg'),
        );
        String value = await reference.getDownloadURL();
        downloadUrl.add(value);
      }

      var reference =
          FirebaseStorage.instance.ref().child('allFiles').child(fileName!);

      try {
        reference.putFile(file!);

        //Success: get the download URL
        String? url = await reference.getDownloadURL();

        debugPrint(url);

        if (url.isNotEmpty || downloadUrl.isNotEmpty) {
          FirebaseFirestore.instance
              .collection("daftar-kkn-kkp")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update(
                  {"pdf": url, "pdfName": fileName, "lampiran": downloadUrl});

          // ignore: use_build_context_synchronously
          MyCustomToast.successToast(context, "Berhasil mengirim laporan");
          setState(() {
            fileName = null;
            file == null;
            isLoading = false;
            _images.clear();
          });
          fungsiDrdb();
        } else {
          // ignore: use_build_context_synchronously
          MyCustomToast.successToast(context, "Tidak ada data yg diperbarui");
          setState(() {
            isLoading = false;
          });
        }
      } on FirebaseException catch (_) {
        // ignore: use_build_context_synchronously
        MyCustomToast.errorToast(context, "Gagal mengirim laporan");
        setState(() {
          isLoading = false;
        });
      }
    } else {
      MyCustomToast.errorToast(context, "Anda belum memilih file");
      setState(() {
        isLoading = false;
      });
    }
  }

  uploadTanpaGambar() async {
    if (fileName != null || file != null) {
      var reference =
          FirebaseStorage.instance.ref().child('allFiles').child(fileName!);

      try {
        reference.putFile(file!);

        //Success: get the download URL
        String? url = await reference.getDownloadURL();

        debugPrint(url);

        if (url.isNotEmpty) {
          FirebaseFirestore.instance
              .collection("daftar-kkn-kkp")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({"pdf": url, "pdfName": fileName});

          // ignore: use_build_context_synchronously
          MyCustomToast.successToast(context, "Berhasil mengirim laporan");
          setState(() {
            fileName = null;
            file == null;
            isLoading = false;
            _images.clear();
          });
          fungsiDrdb();
        } else {
          // ignore: use_build_context_synchronously
          MyCustomToast.successToast(context, "Tidak ada data yg diperbarui");
          setState(() {
            isLoading = false;
          });
        }
      } on FirebaseException catch (_) {
        // ignore: use_build_context_synchronously
        MyCustomToast.errorToast(context, "Gagal mengirim laporan");
        setState(() {
          isLoading = false;
        });
      }
    } else {
      MyCustomToast.errorToast(context, "Anda belum memilih file");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _pickImages(ImageSource source) async {
    callback() {
      Navigator.of(context).pop();
    }

    try {
      List<XFile> pickedImages = await ImagePicker().pickMultiImage();
      if (pickedImages.isNotEmpty) {
        if (_images.length + pickedImages.length > 5) {
          // ignore: use_build_context_synchronously
          Notifikasi.errorAlert(
              context, 'Gambar tidak boleh lebih dari 5', callback);
        } else {
          setState(() {
            _images.addAll(pickedImages
                .map((pickedImage) => File(pickedImage.path))
                .toList());
          });
        }
      }
    } catch (e) {
      MyCustomToast.errorToast(context, e.toString());
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
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
        if (value.data()!['lampiran'] == null) {
        } else {
          lampiran.addAll(
            value.data()!['lampiran'],
          );
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
            width: size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 30.h),
              child: ceking == false
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
                    )
                  : dospem == ""
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
                      : Form(
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
                              Row(
                                children: [
                                  Text(
                                    "Lampiran",
                                    style: CustomTextStyle.heading.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  _images.isNotEmpty
                                      ? SizedBox(
                                          height: 30.h,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0.r),
                                                ),
                                              ),
                                              backgroundColor: _images.length >=
                                                      5
                                                  ? MaterialStateProperty.all(
                                                      CustomColor
                                                          .secondaryColor,
                                                    )
                                                  : MaterialStateProperty.all(
                                                      CustomColor.primaryColor,
                                                    ),
                                              padding:
                                                  MaterialStateProperty.all(
                                                EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (_images.length >= 5) {
                                                null;
                                              } else {
                                                _pickImages(
                                                    ImageSource.gallery);
                                              }
                                            },
                                            child: Text(
                                              "Tambah Gambar",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: _images.length >= 5
                                                    ? CustomColor.black
                                                    : CustomColor.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        )
                                      :
                                      //  lampiran.isNotEmpty
                                      //     ? SizedBox(
                                      //         height: 30.h,
                                      //         child: ElevatedButton(
                                      //           style: ButtonStyle(
                                      //             shape:
                                      //                 MaterialStateProperty.all<
                                      //                     RoundedRectangleBorder>(
                                      //               RoundedRectangleBorder(
                                      //                 borderRadius:
                                      //                     BorderRadius.circular(
                                      //                         5.0.r),
                                      //               ),
                                      //             ),
                                      //             backgroundColor: _images
                                      //                         .length >=
                                      //                     5
                                      //                 ? MaterialStateProperty
                                      //                     .all(
                                      //                     CustomColor
                                      //                         .secondaryColor,
                                      //                   )
                                      //                 : MaterialStateProperty
                                      //                     .all(
                                      //                     CustomColor
                                      //                         .primaryColor,
                                      //                   ),
                                      //             padding:
                                      //                 MaterialStateProperty.all(
                                      //               EdgeInsets.symmetric(
                                      //                   horizontal: 10.w),
                                      //             ),
                                      //           ),
                                      //           onPressed: () async {
                                      //             if (_images.length >= 5) {
                                      //               null;
                                      //             } else {
                                      //               _pickImages(
                                      //                   ImageSource.gallery);
                                      //             }
                                      //           },
                                      //           child: Text(
                                      //             "Update Gambar",
                                      //             style: TextStyle(
                                      //               fontSize: 14.sp,
                                      //               color: _images.length >= 5
                                      //                   ? CustomColor.black
                                      //                   : CustomColor.white,
                                      //               fontWeight: FontWeight.w500,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       )
                                      const SizedBox(),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 140.h,
                                  decoration: BoxDecoration(
                                    color: CustomColor.secondaryColor,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: _images.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: _images.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.w),
                                              child: SizedBox(
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                      child: Image.file(
                                                        _images[index],
                                                        fit: BoxFit.cover,
                                                        width: 150,
                                                        height: 150,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _removeImage(index);
                                                        },
                                                        child: Icon(
                                                          Icons.cancel_rounded,
                                                          size: 38.sp,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : lampiran.isNotEmpty
                                          ? ListView.builder(
                                              itemCount: lampiran.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.w),
                                                  child: SizedBox(
                                                    child: Stack(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          child: Image.network(
                                                            lampiran[index],
                                                            fit: BoxFit.cover,
                                                            width: 150,
                                                            height: 150,
                                                          ),
                                                        ),
                                                        // Align(
                                                        //   alignment:
                                                        //       Alignment.topRight,
                                                        //   child: GestureDetector(
                                                        //     onTap: () {
                                                        //        _removeImage(index);
                                                        //     },
                                                        //     child: Icon(
                                                        //       Icons.cancel_rounded,
                                                        //       size: 38.sp,
                                                        //       color: Colors.red,
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : Center(
                                              child: SizedBox(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _pickImages(
                                                        ImageSource.gallery);
                                                  },
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.image_rounded,
                                                        color: Colors.grey,
                                                        size: 40.sp,
                                                      ),
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      Container(
                                                        height: 30.h,
                                                        width: 140.w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.r),
                                                            border: Border.all(
                                                                width: 1.w,
                                                                color: Colors
                                                                    .grey),
                                                            color: Colors
                                                                .transparent),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      6.0.w),
                                                          child: Center(
                                                            child: Text(
                                                              "Choose Image",
                                                              style: CustomTextStyle
                                                                  .heading
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: CustomColor
                                                                          .black,
                                                                      fontSize:
                                                                          12.sp),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "Nilai (Di isi oleh dospem)",
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
                                height: 15.h,
                              ),
                              Text(
                                "Komentar (Di isi oleh dospem)",
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

                                      _images.isNotEmpty
                                          ? upload()
                                          : uploadTanpaGambar();
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
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
