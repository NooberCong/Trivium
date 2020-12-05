import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn/pages/start_game.dart';
import 'package:flutter_learn/router.dart';
import 'package:flutter_learn/util/shared_prefs.dart';

void main() async {
  _configureSystemSettings();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'NerkoOne'),
      home: const StartScreen(),
      onGenerateRoute: onGenerateRoute,
    );
  }
}

void _configureSystemSettings() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}
