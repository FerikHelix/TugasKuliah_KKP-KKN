import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_kkp_kkn/auth/screen_login.dart';
import 'package:si_kkp_kkn/constant/color.dart';
import 'package:si_kkp_kkn/firebase_options.dart';
import 'package:si_kkp_kkn/screen/screen_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: CustomColor.primaryColor,
                  ),
                ),
              ),
            );
          }
          return ScreenUtilInit(
            designSize: const Size(422.4938, 913.1707),
            builder: (context, child) {
              return MaterialApp(
                theme: ThemeData(
                    brightness: Brightness.light,
                    colorScheme: const ColorScheme.light().copyWith(
                      primary: CustomColor.primaryColor,
                    ),
                    primaryColor: CustomColor.primaryColor,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    textTheme: GoogleFonts.poppinsTextTheme(
                        Theme.of(context).textTheme)),
                debugShowCheckedModeBanner: false,
                home: (snapshot.data != null)
                    ? const ScreenDashboard()
                    : const ScreenLogin(),
              );
            },
          );
        });
  }
}
