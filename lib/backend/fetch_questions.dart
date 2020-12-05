import 'dart:convert';

import 'package:flutter_learn/entities/game_config.dart';
import 'package:flutter_learn/entities/question.dart';
import 'package:http/http.dart' as http;

const String authority = "opentdb.com";
const String path = "/api.php";

Future<List<Question>> fetchQuestions() async {
  http.Response res = await http.get(_buildUri());
  List<Question> questions = (json.decode(res.body)["results"] as List<dynamic>)
      .map((e) => Question.fromJson(e))
      .toList();
  return questions;
}

Uri _buildUri() {
  GameConfig config = GameConfig.get();
  Map<String, String> parameters = {};
  if (config.category.isNotEmpty) {
    parameters["category"] = config.category;
  }
  if (config.difficulty.isNotEmpty) {
    parameters["difficulty"] = config.difficulty;
  }
  if (config.questionType.isNotEmpty) {
    parameters["type"] = config.questionType;
  }
  parameters["amount"] = config.numOfQuestions;
  return Uri.https(authority, path, parameters);
}
