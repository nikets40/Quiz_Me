import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/ui/screens/quiz_prefs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(),
          appBarTheme: AppBarTheme(brightness: Brightness.dark)
        ),
        home: ScreenUtilInit(
          designSize: Size(375, 812),
          allowFontScaling: false,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: QuizPrefs()),
        ));
  }
}
