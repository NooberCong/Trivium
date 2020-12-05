import 'package:flutter/material.dart';
import 'package:flutter_learn/backend/fetch_questions.dart';
import 'package:flutter_learn/entities/question.dart';

class GameController extends StatefulWidget {
  GameController({@required this.child, Key key, this.currentPlayer})
      : super(key: key);
  final Widget child;
  final String currentPlayer;

  @override
  GameControllerState createState() => GameControllerState();
}

class GameControllerState extends State<GameController> {
  List<Question> questions;
  int currQsInd = 0;
  int score = 0;
  bool loadFailed = false;
  bool isLoading = true;

  Question get currentQuestion => questions[currQsInd];
  int get currentInd => currQsInd;
  int get numOfQuestions => questions.length;
  bool get hasNextQuestion => currQsInd < questions.length - 1;
  String get player => widget.currentPlayer;

  void answer(int ansInd) {
    if (questions[currQsInd].correctAnswerInd == ansInd) {
      setState(() {
        score++;
      });
    }
  }

  void nextQuestion() {
    if (currQsInd >= questions.length) {
      throw Exception("No more questions");
    }
    setState(() {
      currQsInd++;
    });
  }

  @override
  void initState() {
    loadQuestions();
    super.initState();
  }

  void loadQuestions() {
    fetchQuestions().then((value) {
      setState(() {
        questions = value;
        isLoading = false;
      });
      debugPrint(value.toString());
    }).catchError((e) {
      setState(() {
        isLoading = false;
        loadFailed = true;
      });
      debugPrint(e.toString());
    });
  }

  void reloadQuestions() {
    setState(() {
      loadFailed = false;
      isLoading = true;
      questions = null;
    });
    loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return GameStateProvider(
      gameState: this,
      child: widget.child,
    );
  }

  static GameControllerState of(BuildContext context, {listen = true}) {
    return (listen
            ? context.dependOnInheritedWidgetOfExactType<GameStateProvider>()
            : context.findAncestorWidgetOfExactType<GameStateProvider>())
        .gameState;
  }
}

class GameStateProvider extends InheritedWidget {
  GameStateProvider({Key key, this.child, this.gameState})
      : super(key: key, child: child);

  final Widget child;
  final GameControllerState gameState;

  @override
  bool updateShouldNotify(GameStateProvider oldWidget) {
    return true;
  }
}
