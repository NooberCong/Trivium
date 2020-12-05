import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_learn/application/game_controller.dart';
import 'package:flutter_learn/components/quiz_body.dart';
import 'package:flutter_learn/constants/colors.dart';
import 'package:flutter_learn/util/screen_size.dart';

class GameScreenArguments {
  final String playerName;

  GameScreenArguments(this.playerName);
}

class GameScreen extends StatelessWidget {
  const GameScreen({Key key, this.arguments}) : super(key: key);
  final GameScreenArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => _confirmExit(context),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: screenHeight(context)),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_randomBgImage()),
                fit: BoxFit.cover,
              ),
            ),
            child: GameController(
              currentPlayer: arguments.playerName,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(
                    context,
                    percentage: 5,
                  ),
                  vertical: screenHeight(
                    context,
                    percentage: 3,
                  ),
                ),
                child: Center(child: QuizzBody()),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _randomBgImage() {
    int rand = Random().nextInt(2);
    return "assets/images/game_bg_$rand.jpg";
  }

  Future<bool> _confirmExit(BuildContext context) async {
    TextTheme textTheme = Theme.of(context).textTheme;

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Are you sure you want to quit?',
        ),
        titleTextStyle: textTheme.headline5.copyWith(color: kPrimaryDark),
        content: Text('All your progress will be lost!'),
        contentTextStyle: textTheme.subtitle2.copyWith(color: Colors.red),
        actions: <Widget>[
          RaisedButton(
              child: Text(
                'Cancel',
                style: textTheme.button.copyWith(
                  color: kPrimaryDark,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(false)),
          RaisedButton(
              color: kFailed,
              child: Text('Quit',
                  style: textTheme.button.copyWith(color: Colors.white)),
              onPressed: () => Navigator.of(context).pop(true)),
        ],
      ),
    );
  }
}
