import 'package:flutter/material.dart';
import 'package:flutter_learn/entities/score.dart';
import 'package:flutter_learn/pages/end_game.dart';
import 'package:flutter_learn/pages/game_settings.dart';
import 'package:flutter_learn/pages/in_game.dart';

const INGAME_ROUTE = "/game";
const ENDGAME_ROUTE = "/end";
const SETTINGS_ROUTE = "/settings";

Route<MaterialPageRoute> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case INGAME_ROUTE:
      return MaterialPageRoute(
        builder: (context) => GameScreen(
          arguments: settings.arguments as GameScreenArguments,
        ),
      );
    case ENDGAME_ROUTE:
      return MaterialPageRoute(
        builder: (context) => EndScreen(
          arguments: settings.arguments as EndScreenArguments,
        ),
      );
    case SETTINGS_ROUTE:
      return MaterialPageRoute(builder: (context) => const SettingsScreen());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text("Eror: 404 not found"),
          ),
        ),
      );
  }
}
