import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:si_kkp_kkn/constant/alert.dart';
import 'package:si_kkp_kkn/constant/buttonStyle.dart';
import 'package:si_kkp_kkn/constant/color.dart';
import 'package:si_kkp_kkn/constant/custom_toast.dart';
import 'package:si_kkp_kkn/constant/inputDecoration.dart';
import 'package:si_kkp_kkn/constant/textStyle.dart';

class ScreenBimbingan extends StatefulWidget {
  final String nameKetua;
  final String bentukKegiatan;
  final String alamatInstansi;
  final String namaInstansi;
  final String waktuBerakhir;
  final String waktuMulai;
  final String dospem;
  final String pdf;
  final String pdfName;
  final String nilai;
  final String komentar;
  final List namaAnggota;
  final String tipe;
  final String alamatPerusahaan;
  final String bidangKerja;
  final String nama;
  final String namaPerusahaan;
  final String pembimbingLapangan;
  final String uid;
  const ScreenBimbingan(
      {super.key,
      required this.nameKetua,
      required this.bentukKegiatan,
      required this.namaInstansi,
      required this.waktuBerakhir,
      required this.waktuMulai,
      required this.namaAnggota,
      required this.alamatInstansi,
      required this.dospem,
      required this.pdf,
      required this.pdfName,
      required this.nilai,
      required this.komentar,
      required this.tipe,
      required this.alamatPerusahaan,
      required this.bidangKerja,
      required this.nama,
      required this.namaPerusahaan,
      required this.pembimbingLapangan,
      required this.uid});

  @override
  State<ScreenBimbingan> createState() => _ScreenBimbinganState();
}

class _ScreenBimbinganState extends State<ScreenBimbingan> {
  bool isLoading = false;
  List namaSemuaAnggota = [];
  TextEditingController nameKetua = TextEditingController();
  TextEditingController bentukKegiatan = TextEditingController();
  TextEditingController namaInstansi = TextEditingController();
  TextEditingController alamatInstansi = TextEditingController();
  TextEditingController waktuMulai = TextEditingController();
  TextEditingController waktuBerakhir = TextEditingController();
  List<TextEditingController> namaAnggota = [TextEditingController()];
  TextEditingController dospem = TextEditingController();
  TextEditingController pdf = TextEditingController();
  TextEditingController pdfName = TextEditingController();
  TextEditingController nilai = TextEditingController();
  TextEditingController komentar = TextEditingController();
  TextEditingController tipe = TextEditingController();
  TextEditingController alamatPerusahaan = TextEditingController();
  TextEditingController bidangKerja = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController namaPerusahaan = TextEditingController();
  TextEditingController pembimbingLapangan = TextEditingController();

  void downloadFile(String url) async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      String savePath = '${dir.path}/${widget.pdfName}';

      var response = await dio.download(url, savePath);
      debugPrint("Download response: $response");

      // ignore: use_build_context_synchronously
      MyCustomToast.successToast(context, "File berhasil diunduh");
    } catch (e) {
      debugPrint("Error downloading file: $e");
      MyCustomToast.errorToast(context, "File gagal diunduh");
    }
  }

  memasukkanKeController() {
    nameKetua.text = widget.nameKetua;
    bentukKegiatan.text = widget.bentukKegiatan;
    namaInstansi.text = widget.namaInstansi;
    alamatInstansi.text = widget.alamatInstansi;
    waktuMulai.text = widget.waktuMulai;
    waktuBerakhir.text = widget.waktuBerakhir;
    dospem.text = widget.dospem;
    pdf.text = widget.pdf;
    pdfName.text = widget.pdfName;
    nilai.text = widget.nilai;
    komentar.text = widget.komentar;
    tipe.text = widget.tipe;
    alamatPerusahaan.text = widget.alamatPerusahaan;
    bidangKerja.text = widget.bidangKerja;
    nama.text = widget.nama;
    namaPerusahaan.text = widget.namaPerusahaan;
    pembimbingLapangan.text = widget.pembimbingLapangan;
    namaSemuaAnggota.addAll(widget.namaAnggota);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    memasukkanKeController();
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
          "Detail",
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
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.h),
              child: widget.tipe == "kkn"
                  ? Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                              controller: nameKetua,
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration:
                                  CustomInputDecoration.primary.copyWith(),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Nama Anggota",
                            style: CustomTextStyle.heading.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 15.sp),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          for (int a = 0; a < namaSemuaAnggota.length; a++) ...{
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10.w),
                              width: double.infinity,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: CustomColor.secondaryColor,
                                borderRadius: BorderRadius.circular(5.r),
                                border: Border.all(
                                    width: 1,
                                    color: CustomColor.secondaryColor),
                              ),
                              child: Text(
                                namaSemuaAnggota[a],
                                style: CustomTextStyle.heading.copyWith(
                                    color: CustomColor.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          },
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
                              minLines: 1,
                              maxLines: 5,
                              controller: namaInstansi,
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration:
                                  CustomInputDecoration.primary.copyWith(),
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
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: CustomColor.secondaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: TextFormField(
                              autofocus: false,
                              controller: alamatInstansi,
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration:
                                  CustomInputDecoration.primary.copyWith(),
                            ),
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
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration:
                                  CustomInputDecoration.primary.copyWith(),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Laporan",
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
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: pdfName,
                                    readOnly: true,
                                    keyboardType: TextInputType.none,
                                    decoration: CustomInputDecoration.primary
                                        .copyWith(),
                                  ),
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    callback() {
                                      Navigator.of(context).pop();
                                    }

                                    if (widget.pdf.isEmpty) {
                                      Notifikasi.errorAlert(context,
                                          "File tidak tersedia", callback);
                                    } else {
                                      downloadFile(widget.pdf);
                                    }
                                  },
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      color: CustomColor.primaryColor,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Icon(
                                      Icons.download_rounded,
                                      size: 22.sp,
                                      color: CustomColor.white,
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
                            "Dospem",
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
                              controller: dospem,
                              readOnly: true,
                              keyboardType: TextInputType.none,
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
                              controller: nilai,
                              // readOnly: true,

                              keyboardType: TextInputType.number,
                              decoration:
                                  CustomInputDecoration.primary.copyWith(),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Komentar",
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
                              // readOnly: true,
                              // keyboardType: TextInputType.none,
                              controller: komentar,
                              decoration:
                                  CustomInputDecoration.primary.copyWith(),
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
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: TextFormField(
                                        readOnly: true,
                                        keyboardType: TextInputType.none,
                                        autofocus: false,
                                        showCursor: false,
                                        controller: waktuMulai,
                                        decoration: CustomInputDecoration
                                            .primary
                                            .copyWith(
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
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: TextFormField(
                                        showCursor: false,
                                        autofocus: false,
                                        controller: waktuBerakhir,
                                        readOnly: true,
                                        keyboardType: TextInputType.none,
                                        decoration: CustomInputDecoration
                                            .primary
                                            .copyWith(
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
                                  if (nilai.text.isNotEmpty &&
                                      komentar.text.isNotEmpty) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection("daftar-kkn-kkp")
                                          .doc(widget.uid)
                                          .update({
                                        "nilai": nilai.text,
                                        "komentar": komentar.text
                                      });

                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pop();
                                      // ignore: use_build_context_synchronously
                                      MyCustomToast.successToast(
                                          context, "Berhasil memberikan nilai");
                                    } on FirebaseException catch (_) {
                                      MyCustomToast.errorToast(
                                          context, "Gagal memberikan nilai");
                                    }
                                  } else {
                                    void callback() {
                                      Navigator.of(context).pop();
                                    }

                                    Notifikasi.errorAlert(
                                        context,
                                        "Harap isi form nilai & komentar",
                                        callback);
                                  }
                                } else {
                                  null;
                                }
                              },
                              style: CustomButton.primaryButton,
                              child: isLoading == false
                                  ? Text(
                                      "Beri Nilai",
                                      style: CustomTextStyle.heading
                                          .copyWith(color: CustomColor.black),
                                    )
                                  : CircularProgressIndicator(
                                      color: CustomColor.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Nama",
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
                              controller: nama,
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration:
                                  CustomInputDecoration.primary.copyWith(),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
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
                              minLines: 1,
                              maxLines: 5,
                              controller: namaPerusahaan,
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration:
                                  CustomInputDecoration.primary.copyWith(),
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
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: CustomColor.secondaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: TextFormField(
                              autofocus: false,
                              controller: alamatPerusahaan,
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration:
                                  CustomInputDecoration.primary.copyWith(),
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
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration:
                                  CustomInputDecoration.primary.copyWith(),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Laporan",
                            style: CustomTextStyle.heading.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 15.sp),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              callback() {
                                Navigator.of(context).pop();
                              }

                              if (widget.pdf.isEmpty) {
                                Notifikasi.errorAlert(
                                    context, "File tidak tersedia", callback);
                              } else {
                                downloadFile(widget.pdf);
                              }
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: CustomColor.secondaryColor,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      autofocus: false,
                                      controller: pdfName,
                                      readOnly: true,
                                      keyboardType: TextInputType.none,
                                      decoration: CustomInputDecoration.primary
                                          .copyWith(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      color: CustomColor.primaryColor,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Icon(
                                      Icons.download_rounded,
                                      size: 22.sp,
                                      color: CustomColor.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Dospem",
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
                              controller: dospem,
                              readOnly: true,
                              keyboardType: TextInputType.none,
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
                              controller: nilai,
                              // readOnly: true,
                              keyboardType: TextInputType.number,
                              decoration:
                                  CustomInputDecoration.primary.copyWith(),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Komentar",
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
                              // readOnly: true,
                              // keyboardType: TextInputType.none,
                              controller: komentar,
                              decoration:
                                  CustomInputDecoration.primary.copyWith(),
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
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: TextFormField(
                                        readOnly: true,
                                        keyboardType: TextInputType.none,
                                        autofocus: false,
                                        showCursor: false,
                                        controller: waktuMulai,
                                        decoration: CustomInputDecoration
                                            .primary
                                            .copyWith(
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
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: TextFormField(
                                        showCursor: false,
                                        autofocus: false,
                                        controller: waktuBerakhir,
                                        readOnly: true,
                                        keyboardType: TextInputType.none,
                                        decoration: CustomInputDecoration
                                            .primary
                                            .copyWith(
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
                                  if (nilai.text.isNotEmpty &&
                                      komentar.text.isNotEmpty) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection("daftar-kkn-kkp")
                                          .doc(widget.uid)
                                          .update({
                                        "nilai": nilai.text,
                                        "komentar": komentar.text
                                      });
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pop();
                                      // ignore: use_build_context_synchronously
                                      MyCustomToast.successToast(
                                          context, "Berhasil memberikan nilai");
                                    } on FirebaseException catch (_) {
                                      MyCustomToast.errorToast(
                                          context, "Gagal memberikan nilai");
                                    }
                                  } else {
                                    void callback() {
                                      Navigator.of(context).pop();
                                    }

                                    Notifikasi.errorAlert(
                                        context,
                                        "Harap isi form nilai & komentar",
                                        callback);
                                  }
                                } else {
                                  null;
                                }
                              },
                              style: CustomButton.primaryButton,
                              child: isLoading == false
                                  ? Text(
                                      "Beri Nilai",
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
