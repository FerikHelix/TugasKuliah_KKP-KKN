import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:si_kkp_kkn/constant/color.dart';
import 'package:si_kkp_kkn/constant/extensionCapitalize.dart';
import 'package:si_kkp_kkn/constant/textStyle.dart';
import 'package:si_kkp_kkn/model/rekapan_nilai_kkp_kkn.dart';
import 'package:si_kkp_kkn/screen/screen_detail_kkpdankkn.dart';
import 'package:pdf/widgets.dart' as pw;

class ScreenListKKPKKN extends StatefulWidget {
  const ScreenListKKPKKN({super.key});

  @override
  State<ScreenListKKPKKN> createState() => _ScreenListKKPKKNState();
}

class _ScreenListKKPKKNState extends State<ScreenListKKPKKN> {
  Stream? getallkkpdankkn;
  @override
  void initState() {
    super.initState();
    getallkkpdankkn =
        FirebaseFirestore.instance.collection("daftar-kkn-kkp").snapshots();
  }

  Future<Uint8List> _generatePdf({
    required PdfPageFormat pageType,
    required List<RekapanNilai> datas,
  }) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: pageType,
        orientation: pw.PageOrientation.landscape,
        build: (context) => pw.Center(
          child: pw.Column(
            children: [
              pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  defaultVerticalAlignment:
                      pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.TableRow(children: [
                      pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Text("Rekapan Nilai KKP & KKN 2023")),
                    ])
                  ]),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text("No"),
                      pw.Text("Tipe"),
                      pw.Text("Dosen Pembimbing"),
                      pw.Text("Pembimbing Lapangan"),
                      pw.Text("Nama Instansi"),
                      pw.Text("Waktu Mulai"),
                      pw.Text("Waktu Berakhir"),
                      pw.Text("Nilai"),
                      pw.Text("Nama Anggota"),
                    ],
                  ),
                  // For data KKP
                  for (int x = 0; x < datas.length; ++x) ...[
                    if (datas[x].tipe == "kkn") ...[
                      pw.TableRow(
                        children: [
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text((x + 1).toString())),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].tipe)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].dosenPembimbing)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].pembimbingLapangan)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].namaInstansi)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].waktuMulai)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].waktuBerakhir)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].nilai)),
                          pw.Container(
                            child: pw.Column(
                              children: [
                                for (final nama in datas[x].namaAnggota) ...[
                                  pw.Align(
                                      alignment: pw.Alignment.centerRight,
                                      child: pw.Text(nama)),
                                  pw.Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: PdfColors.black),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ] else if (datas[x].tipe == "kkp") ...[
                      pw.TableRow(
                        children: [
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text((x + 1).toString())),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].tipe)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].dosenPembimbing)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].pembimbingLapangan)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].namaInstansi)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].waktuMulai)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].waktuBerakhir)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].nilai)),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(datas[x].namaAnggota[0])),
                        ],
                      ),
                    ],
                  ],

                  // For data KKN
                ],
              ),
            ],
          ),
        ),
      ),
    ); // Add a page to the PDF

    return pdf.save();
  }

  Future<List<RekapanNilai>> _getDataKKPKKN() async {
    try {
      final kkpKKNRef =
          await FirebaseFirestore.instance.collection("/daftar-kkn-kkp/").get();
      return kkpKKNRef.docs
          .map((json) => RekapanNilai.fromJson(json.data()))
          .toList();
    } on FirebaseException catch (error) {
      throw Exception("Failed fetching data KKP & KKN");
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
        title: Text(
          "Daftar KKP & KKN",
          style: CustomTextStyle.heading
              .copyWith(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        actions: [
          IconButton(
            tooltip: "Print rekapan nilai semua siswa",
            onPressed: () async {
              await Printing.layoutPdf(
                onLayout: (PdfPageFormat format) async => _generatePdf(
                  pageType: PdfPageFormat.a4,
                  datas: await _getDataKKPKKN(),
                ),
              );
            },
            icon: Icon(
              Icons.print,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: CustomColor.white,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
            child: StreamBuilder(
                stream: getallkkpdankkn,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Error");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          color: CustomColor.primaryColor),
                    );
                  } else if (snapshot.data.docs.isNotEmpty) {
                    final List semudata = [];
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      semudata.add(a);
                      a['id'] = document.id;
                    }).toList();
                    return Column(
                      children: [
                        for (int a = 0; a < semudata.length; a++) ...{
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScreenDetailKKPDANKKN(
                                      dospem: semudata[a]['dospem'],
                                      namaAnggota:
                                          semudata[a]['namaAnggota'] ?? [],
                                      pdf: semudata[a]['pdf'],
                                      pdfName: semudata[a]['pdfName'],
                                      tipe: semudata[a]['tipe'],
                                      waktuMulai: semudata[a]['waktuMulai'],
                                      waktuBerakhir: semudata[a]
                                          ['waktuBerakhir'],
                                      alamatInstansi:
                                          semudata[a]['alamatInstansi'] ?? "-",
                                      alamatPerusahaan: semudata[a]
                                              ['alamatPerusahaan'] ??
                                          "-",
                                      bidangKerja:
                                          semudata[a]['bidangKerja'] ?? "-",
                                      bentukKegiatan:
                                          semudata[a]['bentukKegiatan'] ?? "-",
                                      komentar: semudata[a]['komentar'] ?? "-",
                                      nama: semudata[a]['nama'] ?? "-",
                                      namaInstansi:
                                          semudata[a]['namaInstansi'] ?? "-",
                                      namaPerusahaan:
                                          semudata[a]['namaPerusahaan'] ?? "-",
                                      nameKetua:
                                          semudata[a]['namaKetua'] ?? "-",
                                      nilai: semudata[a]['nilai'] ?? "-",
                                      pembimbingLapangan: semudata[a]
                                              ['pembimbingLapangan'] ??
                                          "-",
                                      lampiran: semudata[a]['lampiran'] ?? [],
                                    ),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    child: Container(
                                      width: double.infinity,
                                      height: 180.h,
                                      decoration: BoxDecoration(
                                        color: CustomColor.primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5.h,
                                    right: 15.w,
                                    child: Icon(
                                      Icons.person_rounded,
                                      size: 50.h,
                                      color: CustomColor.white,
                                    ),
                                  ),
                                  Positioned(
                                    left: -35.w,
                                    bottom: -35.h,
                                    child: CircleAvatar(
                                      radius: 70.r,
                                      backgroundColor:
                                          CustomColor.black.withOpacity(0.2),
                                      child: CircleAvatar(
                                        radius: 48.r,
                                        backgroundColor:
                                            CustomColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5.h,
                                    left: 10.w,
                                    child: SizedBox(
                                      width: 230.w,
                                      child: Text(
                                        semudata[a]['tipe']
                                            .toString()
                                            .toUpperCase(),
                                        style: CustomTextStyle.header.copyWith(
                                            color: CustomColor.white,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                  semudata[a]['tipe'] == "kkn"
                                      ? Positioned(
                                          top: 33.h,
                                          left: 10.w,
                                          child: SizedBox(
                                            child: Row(
                                              children: [
                                                Text(
                                                  semudata[a]['namaKetua']
                                                      .toString()
                                                      .capitalize(),
                                                  style: CustomTextStyle.header
                                                      .copyWith(
                                                          color:
                                                              CustomColor.white,
                                                          fontSize: 20.sp),
                                                ),
                                                for (int b = 0;
                                                    b <
                                                        semudata[a]
                                                                ['namaAnggota']
                                                            .length;
                                                    b++) ...{
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 6.w),
                                                    child: Text(
                                                      ", ${semudata[a]['namaAnggota'][b].toString().capitalize()}",
                                                      style: CustomTextStyle
                                                          .header
                                                          .copyWith(
                                                              color: CustomColor
                                                                  .white,
                                                              fontSize: 20.sp),
                                                    ),
                                                  ),
                                                }
                                              ],
                                            ),
                                          ),
                                        )
                                      : Positioned(
                                          top: 33.h,
                                          left: 10.w,
                                          child: SizedBox(
                                            child: Text(
                                              semudata[a]['nama']
                                                  .toString()
                                                  .capitalize(),
                                              style: CustomTextStyle.header
                                                  .copyWith(
                                                      color: CustomColor.white,
                                                      fontSize: 20.sp),
                                            ),
                                          )),
                                  Positioned(
                                    right: -65.w,
                                    top: -65.h,
                                    child: CircleAvatar(
                                      radius: 70.r,
                                      backgroundColor:
                                          CustomColor.black.withOpacity(0.2),
                                      child: CircleAvatar(
                                        radius: 48.r,
                                        backgroundColor:
                                            CustomColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 85.h,
                                    left: 10.w,
                                    child: SizedBox(
                                      child: Text(
                                        semudata[a]['tipe'] == "kkn"
                                            ? semudata[a]['namaInstansi']
                                            : semudata[a]['namaPerusahaan'],
                                        style: CustomTextStyle.header.copyWith(
                                            color: CustomColor.white,
                                            fontSize: 20.sp),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 42.h,
                                    left: 10.w,
                                    child: SizedBox(
                                      child: Text(
                                        semudata[a]['dospem'] == ""
                                            ? "-"
                                            : "Dospem : ${semudata[a]['dospem'].toString().capitalize()}",
                                        style: CustomTextStyle.header.copyWith(
                                            color: CustomColor.white,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15.h,
                                    left: 10.w,
                                    child: SizedBox(
                                      child: Row(
                                        children: [
                                          Text(
                                            semudata[a]['waktuMulai']
                                                .toString()
                                                .capitalize(),
                                            style: CustomTextStyle.header
                                                .copyWith(
                                                    color: CustomColor.white,
                                                    fontSize: 14.sp),
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Text(
                                            "s/d".toString().capitalize(),
                                            style: CustomTextStyle.header
                                                .copyWith(
                                                    color: CustomColor.white,
                                                    fontSize: 14.sp),
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Text(
                                            semudata[a]['waktuBerakhir']
                                                .toString()
                                                .capitalize(),
                                            style: CustomTextStyle.header
                                                .copyWith(
                                                    color: CustomColor.white,
                                                    fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        }
                      ],
                    );
                  } else {
                    return SizedBox(
                      height: 500,
                      child: Center(
                        child: Text(
                          "Belum ada kkp dan kkn yang terdaftar",
                          style: CustomTextStyle.header.copyWith(
                              color: CustomColor.black, fontSize: 14.sp),
                        ),
                      ),
                    );
                  }
                }),
          ),
        ),
      )),
    );
  }
}
