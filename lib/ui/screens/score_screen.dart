import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreScreen extends StatelessWidget {
  final int score;

  ScoreScreen({@required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff7435E4),
            Color(0xff2B0F92),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Score", style: GoogleFonts.poppins(fontSize: 55.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),),

                  Text("$score/10", style: GoogleFonts.poppins(fontSize: 120.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
