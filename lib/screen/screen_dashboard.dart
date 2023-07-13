import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:si_kkp_kkn/auth/screen_login.dart';
import 'package:si_kkp_kkn/auth/screen_signup.dart';
import 'package:si_kkp_kkn/constant/color.dart';
import 'package:si_kkp_kkn/constant/extensionCapitalize.dart';
import 'package:si_kkp_kkn/constant/textStyle.dart';
import 'package:si_kkp_kkn/screen/screen_daftar_bimbingan.dart';
import 'package:si_kkp_kkn/screen/screen_daftar_kkn.dart';
import 'package:si_kkp_kkn/screen/screen_daftar_kkp.dart';
import 'package:si_kkp_kkn/screen/screen_detail.dart';
import 'package:si_kkp_kkn/screen/screen_list_kkpkkn.dart';
import 'package:si_kkp_kkn/screen/screen_listing_kkpndankkn.dart';
import 'package:si_kkp_kkn/screen/screen_select_dosen.dart';

class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  Stream? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenLogin(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.0.w),
              child: Center(
                child: Text(
                  "Logout",
                  style: CustomTextStyle.paraghraph.copyWith(fontSize: 15.sp),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: CustomColor.white,
            height: size.height,
            width: size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 25.h),
              child: StreamBuilder(
                  stream: user,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Error");
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: CustomColor.primaryColor),
                      );
                    }
                    var data = snapshot.data;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 28.sp,
                              backgroundImage:
                                  const AssetImage("assets/images/avatar.png"),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  data['namaLengkap'].toString().capitalize(),
                                  style: CustomTextStyle.heading,
                                ),
                                data["role"] == "mahasiswa"
                                    ? Text(
                                        data['nim'],
                                        style: CustomTextStyle.paraghraph,
                                      )
                                    : data["role"] == "dospem"
                                        ? Text(
                                            "Dosen Pembimbing",
                                            style: CustomTextStyle.paraghraph,
                                          )
                                        : Text(
                                            "Kaprodi",
                                            style: CustomTextStyle.paraghraph,
                                          ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          "Please choose",
                          style: CustomTextStyle.heading,
                        ),
                        Text(
                          "Bellow this",
                          style: CustomTextStyle.paraghraph,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        data['role'] == "mahasiswa"
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ScreenDaftarKKN()),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5.h,
                                      left: 10.w,
                                      child: SizedBox(
                                        width: 230.w,
                                        child: Text(
                                          "Daftar Kuliah Kerja Nyata",
                                          style: CustomTextStyle.header
                                              .copyWith(
                                                  color: CustomColor.white,
                                                  fontSize: 20.sp),
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
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        data['role'] == "mahasiswa"
                            ? SizedBox(
                                height: 15.h,
                              )
                            : const SizedBox(),
                        data['role'] == "mahasiswa"
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ScreenDaftarKKP()),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5.h,
                                      left: 10.w,
                                      child: SizedBox(
                                        width: 230.w,
                                        child: Text(
                                          "Daftar Kuliah Kerja Praktek",
                                          style: CustomTextStyle.header
                                              .copyWith(
                                                  color: CustomColor.white,
                                                  fontSize: 20.sp),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5.h,
                                      right: 15.w,
                                      child: Icon(
                                        Icons.group_rounded,
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
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        data['role'] == "mahasiswa"
                            ? SizedBox(
                                height: 15.h,
                              )
                            : const SizedBox(),
                        data['role'] == "mahasiswa"
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Detail()));
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      child: Container(
                                        width: double.infinity,
                                        height: 180.h,
                                        decoration: BoxDecoration(
                                          color: CustomColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5.h,
                                      left: 10.w,
                                      child: SizedBox(
                                        width: 230.w,
                                        child: Text(
                                          "Laporan & Nilai",
                                          style: CustomTextStyle.header
                                              .copyWith(
                                                  color: CustomColor.white,
                                                  fontSize: 20.sp),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5.h,
                                      right: 15.w,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.file_copy_rounded,
                                            size: 50.h,
                                            color: CustomColor.white,
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Icon(
                                            Icons.draw_rounded,
                                            size: 50.h,
                                            color: CustomColor.white,
                                          ),
                                        ],
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
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        data['role'] == "kaprodi"
                            ? SizedBox(
                                height: 15.h,
                              )
                            : const SizedBox(),
                        data['role'] == "kaprodi"
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      (MaterialPageRoute(
                                        builder: (context) =>
                                            const ScreenListingKKPKKN(),
                                      )));
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      child: Container(
                                        width: double.infinity,
                                        height: 180.h,
                                        decoration: BoxDecoration(
                                          color: CustomColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5.h,
                                      left: 10.w,
                                      child: SizedBox(
                                        width: 230.w,
                                        child: Text(
                                          "Pilih Dosen Pembimbing",
                                          style: CustomTextStyle.header
                                              .copyWith(
                                                  color: CustomColor.white,
                                                  fontSize: 20.sp),
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
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        data['role'] == "dospem"
                            ? SizedBox(
                                height: 15.h,
                              )
                            : const SizedBox(),
                        data['role'] == "dospem"
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      (MaterialPageRoute(
                                        builder: (context) =>
                                            ScreenDaftarBimbingan(
                                          namaLengkap: data['namaLengkap'],
                                        ),
                                      )));
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      child: Container(
                                        width: double.infinity,
                                        height: 180.h,
                                        decoration: BoxDecoration(
                                          color: CustomColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5.h,
                                      left: 10.w,
                                      child: SizedBox(
                                        width: 230.w,
                                        child: Text(
                                          "Daftar Bimbingan",
                                          style: CustomTextStyle.header
                                              .copyWith(
                                                  color: CustomColor.white,
                                                  fontSize: 20.sp),
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
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        data['role'] == "kaprodi"
                            ? SizedBox(
                                height: 15.h,
                              )
                            : const SizedBox(),
                        data['role'] == "kaprodi"
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      (MaterialPageRoute(
                                        builder: (context) =>
                                            const ScreenListKKPKKN(),
                                      )));
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      child: Container(
                                        width: double.infinity,
                                        height: 180.h,
                                        decoration: BoxDecoration(
                                          color: CustomColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5.h,
                                      left: 10.w,
                                      child: SizedBox(
                                        width: 230.w,
                                        child: Text(
                                          "Kelola KKN/KKP",
                                          style: CustomTextStyle.header
                                              .copyWith(
                                                  color: CustomColor.white,
                                                  fontSize: 20.sp),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5.h,
                                      right: 15.w,
                                      child: Icon(
                                        Icons.draw_rounded,
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
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        data['role'] == "kaprodi"
                            ? SizedBox(
                                height: 15.h,
                              )
                            : const SizedBox(),
                        data['role'] == "kaprodi"
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      (MaterialPageRoute(
                                        builder: (context) =>
                                            const ScreenSignup(),
                                      )));
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      child: Container(
                                        width: double.infinity,
                                        height: 180.h,
                                        decoration: BoxDecoration(
                                          color: CustomColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5.h,
                                      left: 10.w,
                                      child: SizedBox(
                                        width: 230.w,
                                        child: Text(
                                          "Kelola Akun",
                                          style: CustomTextStyle.header
                                              .copyWith(
                                                  color: CustomColor.white,
                                                  fontSize: 20.sp),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5.h,
                                      right: 15.w,
                                      child: Icon(
                                        Icons.person_add_rounded,
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
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 25.h,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                style: CustomTextStyle.heading.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
