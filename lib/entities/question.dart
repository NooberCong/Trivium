import 'dart:math';

import 'package:flutter_learn/util/html_unscape.dart';

enum Difficulty { Easy, Medium, Hard }

Difficulty _toDiff(String text) {
  switch (text) {
    case "hard":
      return Difficulty.Hard;
    case "medium":
      return Difficulty.Medium;
    case "easy":
      return Difficulty.Easy;
    default:
      throw Exception("Invalid difficulty");
  }
}

class Question {
  final String category;
  final Difficulty difficulty;
  final String text;
  final int correctAnswerInd;
  final List<String> answers;

  Question(this.category, this.difficulty, this.text, this.correctAnswerInd,
      this.answers);

  factory Question.fromJson(Map<String, dynamic> json) {
    String correctAnswer = json["correct_answer"] as String;
    List<String> answers = (json["incorrect_answers"] as List)
        .map((e) => unescape(e as String))
        .toList();
    int correctInd = Random().nextInt(answers.length);
    answers.insert(correctInd, correctAnswer);
    return Question(
        json["category"] as String,
        _toDiff(json["difficulty"] as String),
        unescape(json["question"] as String),
        correctInd,
        answers);
  }
}
