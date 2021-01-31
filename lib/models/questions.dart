import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class Questions {
  int responseCode;
  int statusCode;
  List<Results> results;

  Questions({this.responseCode, this.results, this.statusCode});

  Questions.fromJson(Map<String, dynamic> json, statusCode) {
    this.statusCode = statusCode;
    responseCode = json['response_code'];
    if (json['results'] != null) {
      results = new List<Results>.empty(growable: true);
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }
}

class Results {
  String category;
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  Results(
      {this.category,
        this.type,
        this.difficulty,
        this.question,
        this.correctAnswer,
        this.incorrectAnswers});

  Results.fromJson(Map<String, dynamic> json) {
    var unescape = new HtmlUnescape();
    category = unescape.convert(json['category']);
    type = unescape.convert(json['type']);
    difficulty = unescape.convert(json['difficulty']);
    question = unescape.convert(json['question']);
    correctAnswer = unescape.convert(json['correct_answer']);
    incorrectAnswers = json['incorrect_answers'].cast<String>();
    for(int i = 0 ; i<incorrectAnswers.length;i++){
      incorrectAnswers[i] = unescape.convert(incorrectAnswers[i]);
    }
  }
}
