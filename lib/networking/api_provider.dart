import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:quiz_app/models/categories.dart';
import 'package:quiz_app/models/questions.dart';

class ApiProvider {
  final String baseURL = "https://opentdb.com/";

  Future<Categories> fetchCategories({@required BuildContext context}) async {
    var categories = await DefaultAssetBundle.of(context)
        .loadString('assets/json/trivia_categories.json');
    return Categories.fromJson(jsonDecode(categories));
  }

  Future<Questions> fetchQuestions(
      {@required int categoryID,
      @required int numberOFQuestions,
      @required String difficulty}) async {
    String url = baseURL +
        "api.php?amount=$numberOFQuestions&category=$categoryID&difficulty=${difficulty.toLowerCase()}&type=multiple";
    print(url);
    final http.Response response = await http.get(url);

    print(response.body);

    return Questions.fromJson(jsonDecode(response.body), response.statusCode);
  }
}
