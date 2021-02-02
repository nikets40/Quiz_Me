import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/customRoute.dart';
import 'package:quiz_app/models/optionsData.dart';
import 'package:quiz_app/ui/screens/get_ready_screen.dart';
import 'package:quiz_app/ui/screens/questionScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/ui/screens/score_screen.dart';

class CorrectAnswerScreen extends StatefulWidget {
  final OptionsData data;
  final int score;
  final int questionNumber;


  CorrectAnswerScreen({this.data, this.score,this.questionNumber});

  @override
  _CorrectAnswerScreenState createState() => _CorrectAnswerScreenState();
}

class _CorrectAnswerScreenState extends State<CorrectAnswerScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  ConfettiController _confettiController = new ConfettiController();
  bool showMessage = false;
  bool showScreen= true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
          Duration(milliseconds: 1000), cardKey.currentState.toggleCard);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _confettiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff7435E4),
          Color(0xff2B0F92),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: WillPopScope(
          onWillPop: ()async=>false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Center(
                child: Opacity(
                  opacity:showScreen?1:0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: showMessage ? 1 : 0,
                        child: Text(
                          widget.data.isCorrect ? "Correct!" : "Oops!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 54.sp,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: AspectRatio(
                          aspectRatio: 1.25,
                          child: Container(
                              child: ConfettiWidget(
                            confettiController: _confettiController,
                            blastDirectionality: BlastDirectionality.explosive,
                            blastDirection: pi,
                            child: Hero(
                              tag: widget.data.option,
                              child: FlipCard(
                                flipOnTouch: false,
                                onFlipDone: (bool) {
                                  if (widget.data.isCorrect)
                                    _confettiController.play();
                                  Future.delayed(Duration(seconds: 3), () async{
                                    setState(() {
                                      showScreen=false;
                                    });
                                    if(widget.questionNumber==10)
                                      {
                                        Navigator.of(context).pushAndRemoveUntil(AnimatedPageRoute(ScoreScreen(score: widget.score,)),(route) => false);
                                      }
                                    else{
                                      await Navigator.of(context).push(AnimatedPageRoute(GetReadyScreen()));
                                      Navigator.of(context).pop();
                                    }
                                  });
                                  setState(() {
                                    showMessage = true;
                                  });
                                },
                                speed: 1000,
                                key: cardKey,
                                back: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: widget.data.isCorrect
                                        ? CircleAvatar(
                                            backgroundColor: Colors.green,
                                            radius:
                                                MediaQuery.of(context).size.width /
                                                    6,
                                            child: Icon(
                                              Icons.check_rounded,
                                              color: Colors.white,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.redAccent,
                                            radius:
                                                MediaQuery.of(context).size.width /
                                                    6,
                                            child: Icon(
                                              Icons.close_rounded,
                                              color: Colors.white,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                            ),
                                          ),
                                  ),
                                ),
                                front: OptionCard(
                                  optionsData: widget.data,
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: (!widget.data.isCorrect && showMessage) ? 1 : 0,
                        child: Column(
                          children: [
                            Text(
                              "The Correct Answer is",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.sp,
                                  color: Colors.white),
                            ),
                            Text(
                              "${widget.data.correctAnswer}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 26.sp,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
