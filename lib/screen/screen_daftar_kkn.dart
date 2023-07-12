import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:si_kkp_kkn/constant/alert.dart';
import 'package:si_kkp_kkn/constant/buttonStyle.dart';
import 'package:si_kkp_kkn/constant/color.dart';
import 'package:si_kkp_kkn/constant/custom_toast.dart';
import 'package:si_kkp_kkn/constant/inputDecoration.dart';
import 'package:si_kkp_kkn/constant/textStyle.dart';

class ScreenDaftarKKN extends StatefulWidget {
  const ScreenDaftarKKN({super.key});

  @override
  State<ScreenDaftarKKN> createState() => _ScreenDaftarKKNState();
}

class _ScreenDaftarKKNState extends State<ScreenDaftarKKN> {
  bool isLoading = false;
  TextEditingController nameLeader = TextEditingController();

  TextEditingController bentukKegiatan = TextEditingController();
  TextEditingController namaInstansi = TextEditingController();
  TextEditingController alamatInstansi = TextEditingController();
  TextEditingController waktuMulai = TextEditingController();
  TextEditingController waktuBerakhir = TextEditingController();

  String _formatDate(String date) {
    return date.replaceAll('00:00:00.000', '');
  }

  String _formatDate2(String date) {
    return date.replaceAll('00:00:00.000', '');
  }

  List<TextEditingController> namaControllers = [TextEditingController()];

  void addField() {
    setState(() {
      namaControllers.add(TextEditingController());
    });
  }

  void removeField(int index) {
    setState(() {
      namaControllers.removeAt(index);
    });
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
          "Pendaftaran KKN",
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
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      "Nama Ketua",
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
                        controller: nameLeader,
                        decoration: CustomInputDecoration.primary
                            .copyWith(hintText: "Masukkan nama ketua"),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Nama Anggota",
                          style: CustomTextStyle.heading.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 15.sp),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "(Max: 3)",
                          style: CustomTextStyle.heading.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: namaControllers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: CustomColor.secondaryColor,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: TextFormField(
                                    controller: namaControllers[index],
                                    autofocus: false,
                                    decoration: CustomInputDecoration.primary
                                        .copyWith(hintText: "Nama anggota"),
                                  ),
                                ),
                              ),
                              index == 0
                                  ? SizedBox(
                                      width: 10.w,
                                    )
                                  : const SizedBox(),
                              index == 0
                                  ? GestureDetector(
                                      onTap: () {
                                        if (namaControllers.length < 3) {
                                          addField();
                                        } else {
                                          null;
                                        }
                                      },
                                      child: Icon(
                                        Icons.add_box_rounded,
                                        color: CustomColor.primaryColor,
                                        size: 35.sp,
                                      ),
                                    )
                                  : const SizedBox(),
                              index != 0
                                  ? SizedBox(
                                      width: 10.w,
                                    )
                                  : const SizedBox(),
                              index != 0
                                  ? GestureDetector(
                                      onTap: () {
                                        removeField(index);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: CustomColor.primaryColor,
                                        size: 35.sp,
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Bentuk Kegiatan",
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
                        controller: bentukKegiatan,
                        decoration: CustomInputDecoration.primary.copyWith(
                          hintText: "Masukkan bentuk kegiatan",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Nama Instansi",
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
                        controller: namaInstansi,
                        decoration: CustomInputDecoration.primary.copyWith(
                          hintText: "Masukkan nama instansi",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Alamat Instansi",
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
                        controller: alamatInstansi,
                        decoration: CustomInputDecoration.primary.copyWith(
                          hintText: "Masukkan alamat instansi",
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
                                    setState(() {
                                      if (dateTime1 != null) {
                                        waktuMulai.text =
                                            _formatDate2(dateTime1.toString());
                                      }
                                    });
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
                                    setState(() {
                                      if (dateTime2 != null) {
                                        waktuBerakhir.text =
                                            _formatDate(dateTime2.toString());
                                      }
                                    });
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
                            if (nameLeader.text.isNotEmpty &&
                                namaControllers.isNotEmpty &&
                                bentukKegiatan.text.isNotEmpty &&
                                namaInstansi.text.isNotEmpty &&
                                alamatInstansi.text.isNotEmpty &&
                                waktuMulai.text.isNotEmpty &&
                                waktuBerakhir.text.isNotEmpty) {
                              List<String> namaAnggota = [];

                              for (var controller in namaControllers) {
                                String itemText = controller.text;

                                if (itemText.isNotEmpty) {
                                  namaAnggota.add(itemText);
                                }
                              }
                              setState(() {
                                isLoading = true;
                              });
                              await FirebaseFirestore.instance
                                  .collection("registration-kkn-kkp")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                "iddoc": FirebaseAuth.instance.currentUser!.uid,
                                "namaKetua": nameLeader.text,
                                "namaAnggota": namaAnggota,
                                "bentukKegiatan": bentukKegiatan.text,
                                "namaInstansi": namaInstansi.text,
                                "alamatInstansi": alamatInstansi.text,
                                "waktuMulai": waktuMulai.text,
                                "waktuBerakhir": waktuBerakhir.text,
                              });
                              // ignore: use_build_context_synchronously
                              MyCustomToast.successToast(
                                  context, "Berhasil mendaftar KKN");
                              setState(() {
                                isLoading = false;
                                nameLeader.clear();
                                namaControllers.clear();
                                bentukKegiatan.clear();
                                namaInstansi.clear();
                                alamatInstansi.clear();
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
                                "Daftar KKN",
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
