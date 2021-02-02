import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/categories.dart';
import 'package:quiz_app/networking/api_provider.dart';
import 'package:quiz_app/ui/screens/questionScreen.dart';
import 'package:quiz_app/ui/widgets/difficulty_button.dart';

class QuizPrefs extends StatefulWidget {
  @override
  _QuizPrefsState createState() => _QuizPrefsState();
}

class _QuizPrefsState extends State<QuizPrefs> {
  String _category;
  double numberOfQuestions = 10;
  bool isLoadingQuestions = false;

  Categories _categories = new Categories();
  String difficultyLevel = "Easy";
  var textGroup = AutoSizeGroup();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categories.triviaCategories = [];
    ApiProvider().fetchCategories(context: context).then((value) {
      setState(() {
        _categories = value;
      });
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
          body: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('Tap back again to leave'),
            ),
            child: SafeArea(
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/book.svg",
                              height: 40.h,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Quiz ME",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "Select a Category:",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 24.sp)),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                            isExpanded: true,
                            value: _category,
                            hint: Text("Choose Category..."),
                            items: _categories.triviaCategories.map((value) {
                              return new DropdownMenuItem<String>(
                                value: value.name,
                                child: new Text(value.name),
                              );
                            }).toList(),
                            onChanged: (_) {
                              setState(() {
                                _category = _;
                              });
                            },
                          )),
                        ),
                      ),
                      // SizedBox(
                      //   height: 30.h,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       "Number of Questions: ",
                      //       style: GoogleFonts.poppins(
                      //           textStyle: TextStyle(
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.w600,
                      //               fontSize: 24.sp)),
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //           border:
                      //               Border.all(color: Colors.white, width: 4)),
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             vertical: 5.0, horizontal: 10),
                      //         child: Text(
                      //           numberOfQuestions.round().toString(),
                      //           style: GoogleFonts.poppins(
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.w600,
                      //               fontSize: 20.sp),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisSize: MainAxisSize.max,
                      //   children: [
                      //     Text(
                      //       "5",
                      //       style: GoogleFonts.poppins(
                      //           textStyle: TextStyle(
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.w600,
                      //               fontSize: 24.sp)),
                      //     ),
                      //     Expanded(
                      //         child: Slider(
                      //       value: numberOfQuestions,
                      //       onChanged: (val) {
                      //         setState(() {
                      //           numberOfQuestions = val;
                      //         });
                      //       },
                      //       min: 5,
                      //       max: 50,
                      //       activeColor: Color(0xffEB155B),
                      //       inactiveColor: Colors.white,
                      //       label: numberOfQuestions.toString(),
                      //     )),
                      //     Text(
                      //       "50",
                      //       style: GoogleFonts.poppins(
                      //           textStyle: TextStyle(
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.w600,
                      //               fontSize: 24.sp)),
                      //     ),
                      //   ],
                      // ),

                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Difficulty:",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.sp)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 4)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                              child: Text(
                                difficultyLevel,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DifficultyButton(
                            backgroundColor: Color(0xffE6F8E4),
                            borderColor: Color(0xff72DC73),
                            label: "Easy",
                            textGroup: textGroup,
                            onPressed: () {
                              setState(() {
                                difficultyLevel = "Easy";
                              });
                            },
                          ),
                          DifficultyButton(
                            backgroundColor: Color(0xffFFE4CD),
                            borderColor: Color(0xffFA9224),
                            label: "Medium",
                            textGroup: textGroup,
                            onPressed: () {
                              setState(() {
                                difficultyLevel = "Medium";
                              });
                            },
                          ),
                          DifficultyButton(
                            backgroundColor: Color(0xffFFD5D6),
                            borderColor: Color(0xffF84D57),
                            label: "Hard",
                            textGroup: textGroup,
                            onPressed: () {
                              setState(() {
                                difficultyLevel = "Hard";
                              });
                            },
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        height: 60.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: onStartQuiz,
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
                                isLoadingQuestions?"Loading...":"Start Quiz",
                                style: GoogleFonts.poppins(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),
                              ),
                              Opacity(
                                opacity: isLoadingQuestions?0:1,
                                child: Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: Colors.deepPurple,
                                  size: 50,
                                ),
                              )
                            ],
                          ),
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
          ),
        ));
  }

  onStartQuiz() async {
    if (_category != null) {
      try {
        setState(() {
          isLoadingQuestions =true;
        });
        var questions = await ApiProvider().fetchQuestions(
            categoryID: _categories.triviaCategories
                .firstWhere((element) => element.name == _category)
                .id,
            numberOFQuestions: numberOfQuestions.toInt(),
            difficulty: difficultyLevel);
        setState(() {
          isLoadingQuestions =false;
        });
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => QuestionScreen(
                  questions: questions,
                )));
      } catch (e) {
        log(e.toString());
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Oops!..."),
                  content: Text(
                      "Something Wrong with your connection.\nPlease! Try Again"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Future.delayed(
                              Duration(milliseconds: 400), () => onStartQuiz());
                        },
                        child: Text("Retry!"))
                  ],
                ));
      }
    } else
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
            return AlertDialog(
              title: Text("Please Select a category!"),
            );
          });
  }
}
