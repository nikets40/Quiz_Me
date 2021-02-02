import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/ui/screens/quiz_prefs_screen.dart';

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
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to Exit'),
          ),
          child: SafeArea(
            child: Container(
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Spacer(),
                    Text("Score", style: GoogleFonts.poppins(fontSize: 55.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),

                    Text("$score/10", style: GoogleFonts.poppins(fontSize: 120.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20.0),
                      child: SizedBox(
                        height: 60.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: (){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>QuizPrefs()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Opacity(
                                  opacity: 0,
                                  child: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: Colors.deepPurple,
                                    size: 50,
                                  )),
                              Text(
                               "Main Menu",
                                style: GoogleFonts.poppins(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: Colors.deepPurple,
                                size: 50,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h,)

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
