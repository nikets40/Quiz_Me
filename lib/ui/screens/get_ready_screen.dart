import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetReadyScreen extends StatefulWidget {
  @override
  _GetReadyScreenState createState() => _GetReadyScreenState();
}

class _GetReadyScreenState extends State<GetReadyScreen> {

  int time = 3;
  bool showScreen = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time--;
      });
      if (time==0){
        timer.cancel();
        setState(() {
          showScreen=false;
        });
        Future.delayed(Duration(seconds: 1),()=>Navigator.pop(context));
      }

    });
  }

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
          child: AnimatedOpacity(
            opacity: showScreen?1:0,
            duration: Duration(milliseconds: 500),
            child: Container(
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Get Ready", style: GoogleFonts.poppins(fontSize: 55.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                    Text("0$time", style: GoogleFonts.poppins(fontSize: 120.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),)
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
