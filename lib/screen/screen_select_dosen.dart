import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:si_kkp_kkn/constant/buttonStyle.dart';
import 'package:si_kkp_kkn/constant/color.dart';
import 'package:si_kkp_kkn/constant/custom_toast.dart';
import 'package:si_kkp_kkn/constant/extensionCapitalize.dart';
import 'package:si_kkp_kkn/constant/textStyle.dart';

class ScreenSelectDosen extends StatefulWidget {
  String uid;
  ScreenSelectDosen({super.key, required this.uid});

  @override
  State<ScreenSelectDosen> createState() => _ScreenSelectDosenState();
}

class _ScreenSelectDosenState extends State<ScreenSelectDosen> {
  bool ceking = false;
  bool isLoading = false;
  String dospem = "";
  String? selectedDospem;

  Future? getDB;

  void fungsiDrdb() async {
    await FirebaseFirestore.instance
        .collection("daftar-kkn-kkp")
        .doc(widget.uid)
        .get()
        .then((value) {
      setState(() {
        ceking = value.exists;
        if (value.data()?['dospem'] != null) {
          dospem = value.data()!['dospem'];
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fungsiDrdb();
    getDB = FirebaseFirestore.instance
        .collection("users")
        .where("role", isEqualTo: "dospem")
        .get();
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
          "Pilih Dosen",
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
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Pilih Dosen",
                      style: CustomTextStyle.heading.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    dospem == ""
                        ? FutureBuilder(
                            future: getDB,
                            builder: (BuildContext context, snapshot) {
                              List<DropdownMenuItem> kategoriItem = [];
                              const List<String> list = <String>[
                                'Pilih Dospem',
                              ];
                              String dropdownValue = list.first;
                              if (snapshot.hasData) {
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  DocumentSnapshot data =
                                      snapshot.data!.docs[i];
                                  kategoriItem.add(
                                    DropdownMenuItem(
                                      value: data['namaLengkap'],
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: Text(
                                          data['namaLengkap']
                                              .toString()
                                              .capitalize(),
                                          style: TextStyle(
                                              color: CustomColor.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: CustomColor.secondaryColor,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      menuMaxHeight: 300.h,
                                      items: kategoriItem,
                                      onChanged: (kategoriValue) {
                                        setState(() {
                                          selectedDospem = kategoriValue;
                                        });
                                      },
                                      value: selectedDospem,
                                      isExpanded: true,
                                      hint: Padding(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: Text(
                                          "Pilih Dospem",
                                          style: TextStyle(
                                              color: CustomColor.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: CustomColor.secondaryColor,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      hint: Padding(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: Text(
                                          "Pilih Dospem",
                                          style: TextStyle(
                                              color: CustomColor.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      isExpanded: false,
                                      onChanged: (value) {},
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Text(
                                              value.toString().capitalize(),
                                              style: TextStyle(
                                                  color: CustomColor.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              }
                            })
                        : Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: CustomColor.secondaryColor,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dospem,
                                    style: TextStyle(
                                        color: CustomColor.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(
                                    Icons.lock_person_rounded,
                                    size: 24.sp,
                                    color: CustomColor.black,
                                  )
                                ],
                              ),
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
                          if (dospem == "") {
                            if (isLoading == false) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                if (selectedDospem != null) {
                                  FirebaseFirestore.instance
                                      .collection("daftar-kkn-kkp")
                                      .doc(widget.uid)
                                      .update({"dospem": selectedDospem});
                                  fungsiDrdb();
                                  MyCustomToast.successToast(
                                      context, "Berhasil menetapkan dosen");
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  MyCustomToast.errorToast(
                                      context, "Gagal menetapkan dosen");
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              } on FirebaseException catch (_) {
                                MyCustomToast.errorToast(
                                    context, "Gagal menetapkan dosen");
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            } else {}
                          } else {}
                        },
                        style: CustomButton.primaryButton,
                        child: isLoading == false
                            ? Text(
                                "Tetapkan Dosen",
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
