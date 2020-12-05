import 'dart:convert';

import 'package:flutter_learn/util/shared_prefs.dart';

const CONFIG_KEY = "config";

const Map<String, String> categories = {
  "All": "",
  "General Knowledge": "9",
  "Entertainment: Books": "10",
  "Entertainment: Film": "11",
  "Entertainment: Music": "12",
  "Entertainment: Musicals & Theaters": "13",
  "Entertainment: Television": "14",
  "Entertainment: Video Games": "15",
  "Entertainment: Board Games": "16",
  "Science & Nature": "17",
  "Science: Computers": "18",
  "Science: Mathematics": "19",
  "Mythology": "20",
  "Sports": "21",
  "Geography": "22",
  "History": "23",
  "Politics": "24",
  "Art": "25",
  "Celebrities": "26",
  "Animals": "27",
  "Vehicles": "28",
  "Entertainment: Comics": "29",
  "Science: Gadgets": "30",
  "Entertainment: Japanese Anime & Manga": "31",
  "Entertainment: Cartoon & Animations": "32"
};

const Map<String, String> difficulties = {
  "All": "",
  "Easy": "easy",
  "Medium": "medium",
  "Hard": "hard",
};

const Map<String, String> questionTypes = {
  "All": "",
  "Multiple Choice": "multiple",
  "True / False": "boolean",
};

const List<String> numsOfQuestions = ["10", "20", "30", "40", "50"];

class GameConfig {
  String category;
  String difficulty;
  String questionType;
  String numOfQuestions;

  GameConfig({
    this.category = "",
    this.difficulty = "",
    this.questionType = "",
    this.numOfQuestions = "10",
  });

  factory GameConfig._fromJson(Map<String, dynamic> json) {
    return GameConfig(
        category: json["category"] as String,
        difficulty: json["difficulty"] as String,
        questionType: json["questionType"] as String,
        numOfQuestions: json["numOfQuestions"] as String);
  }

  static GameConfig get() {
    if (!SharedPrefsHelper.instance.containsKey(CONFIG_KEY)) {
      return GameConfig();
    }
    return GameConfig._fromJson(
        json.decode(SharedPrefsHelper.instance.getString(CONFIG_KEY)));
  }

  String _serialize() {
    return json.encode({
      "category": category,
      "difficulty": difficulty,
      "questionType": questionType,
      "numOfQuestions": numOfQuestions,
    });
  }

  void save() {
    SharedPrefsHelper.instance.setString(CONFIG_KEY, _serialize());
  }
}
