import 'package:flutter/material.dart';
import 'package:flutter_learn/constants/colors.dart';
import 'package:flutter_learn/entities/game_config.dart';
import 'package:flutter_learn/util/screen_size.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GameConfig config;

  @override
  void initState() {
    super.initState();
    config = GameConfig.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Settings\n",
              style: TextStyle(fontSize: 36, color: Colors.white),
            ),
            Container(
              width: screenWidth(context, percentage: 90),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(fontSize: 24, color: kPrimary),
                    ),
                    DropdownButton(
                      value: config.category,
                      items: categories.keys
                          .map(
                            (key) => DropdownMenuItem<String>(
                              value: categories[key],
                              child: Text(key),
                            ),
                          )
                          .toList(),
                      onChanged: (newValue) {
                        config.category = newValue;
                        _save();
                      },
                    ),
                    Text(
                      "Question Difficulty",
                      style: TextStyle(fontSize: 20, color: kPrimary),
                    ),
                    DropdownButton(
                      value: config.difficulty,
                      items: difficulties.keys
                          .map(
                            (key) => DropdownMenuItem<String>(
                              value: difficulties[key],
                              child: Text(key),
                            ),
                          )
                          .toList(),
                      onChanged: (newValue) {
                        config.difficulty = newValue;
                        _save();
                      },
                    ),
                    Text(
                      "Question Type",
                      style: TextStyle(fontSize: 20, color: kPrimary),
                    ),
                    DropdownButton(
                      value: config.questionType,
                      items: questionTypes.keys
                          .map(
                            (key) => DropdownMenuItem<String>(
                              value: questionTypes[key],
                              child: Text(key),
                            ),
                          )
                          .toList(),
                      onChanged: (newValue) {
                        config.questionType = newValue;
                        _save();
                      },
                    ),
                    Text(
                      "Question Count",
                      style: TextStyle(fontSize: 20, color: kPrimary),
                    ),
                    DropdownButton(
                      value: config.numOfQuestions,
                      items: numsOfQuestions
                          .map(
                            (n) => DropdownMenuItem<String>(
                              value: n,
                              child: Text(n),
                            ),
                          )
                          .toList(),
                      onChanged: (newValue) {
                        config.numOfQuestions = newValue;
                        _save();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    config.save();
    setState(() {});
  }
}
