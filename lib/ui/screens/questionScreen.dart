import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/optionsData.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:quiz_app/ui/screens/correct_answer_screen.dart';
import 'package:quiz_app/customRoute.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionScreen extends StatefulWidget {
  final Questions questions;

  QuestionScreen({@required this.questions});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  CountDownController _countDownController = new CountDownController();
  int _counter = 0;
  int _scoreCount = 0;
  final List<Color> optionColors = [
    Colors.amber,
    Colors.blueAccent,
    Colors.green,
    Colors.redAccent
  ];

  List<String> options = new List<String>.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateOptions();
  }

  updateOptions() {
    options = widget.questions.results[_counter].incorrectAnswers;
    options.add(widget.questions.results[_counter].correctAnswer);
    options.shuffle();
  }

  nextQuestion() {
    if (_counter < widget.questions.results.length - 1)
      setState(() {
        _counter++;
        updateOptions();
        _countDownController.restart();
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
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Spacer(),
                    SvgPicture.asset(
                      "assets/icons/book.svg",
                      height: 40.h,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Quiz ME :-   ",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ),
                    // Spacer(),
                    Text(
                      "${_counter + 1}/${widget.questions.results.length}",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                          color: Colors.white),
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child:
                      AutoSizeText(widget.questions.results[_counter].question,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 25.sp),
                          )),
                ),
                Spacer(),
                GestureDetector(
                  onTap: _countDownController.start,
                  onLongPress: _countDownController.pause,
                  child: CircularCountDownTimer(
                    onComplete: nextQuestion,
                    duration: 60,
                    controller: _countDownController,
                    width: 135.w,
                    height: 135.h,
                    color: Colors.grey[300],
                    fillColor: Color(0xffEB155B),
                    backgroundColor: Colors.transparent,
                    strokeWidth: 15.h,
                    strokeCap: StrokeCap.round,
                    textStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    textFormat: CountdownTextFormat.MM_SS,
                    isReverse: true,
                    isReverseAnimation: false,
                    isTimerTextShown: true,
                    autoStart: true,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GridView.count(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width / 350.h,
                    children: List.generate(4, (index) {
                      OptionsData optionsData = new OptionsData(
                          color: optionColors[index],
                          isCorrect: options[index] ==
                              widget.questions.results[_counter].correctAnswer,
                          option: options[index],
                          optionLetter: ["A", "B", "C", "D"][index],
                          correctAnswer:
                              widget.questions.results[_counter].correctAnswer);
                      return SizedBox(
                        child: Hero(
                          tag: options[index],
                          child: GestureDetector(
                            onTap: () async {
                              _countDownController.pause();
                              if(options[index] == widget.questions.results[_counter].correctAnswer)
                                ++_scoreCount;
                              await Navigator.of(context)
                                  .push(AnimatedPageRoute(CorrectAnswerScreen(
                                data: optionsData,
                                questionNumber: _counter+1,
                                score: _scoreCount,
                              )));

                              nextQuestion();
                            },
                            child: OptionCard(
                              optionsData: optionsData,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OptionCard extends StatefulWidget {
  final OptionsData optionsData;

  OptionCard({@required this.optionsData});

  @override
  _OptionCardState createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Column(
            children: [
              Spacer(),
              CircleAvatar(
                backgroundColor: widget.optionsData.color,
                radius: 25,
                child: Text(
                  widget.optionsData.optionLetter,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              Spacer(),
              AutoSizeText(
                widget.optionsData.option,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, fontSize: 24),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
