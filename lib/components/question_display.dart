import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/application/game_controller.dart';
import 'package:flutter_learn/components/answer_display.dart';
import 'package:flutter_learn/constants/colors.dart';
import 'package:flutter_learn/entities/question.dart';
import 'package:flutter_learn/entities/score.dart';
import 'package:flutter_learn/pages/end_game.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionDisplay extends StatefulWidget {
  QuestionDisplay({Key key, @required this.question}) : super(key: key);

  final Question question;

  @override
  _QuestionDisplayState createState() => _QuestionDisplayState();
}

class _QuestionDisplayState extends State<QuestionDisplay> {
  bool answered = false;
  int selectedAnsInd = -1;
  // Key used to reset timer state when a new question is loaded
  UniqueKey timerKey = UniqueKey();
  GameControllerState state;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = GameControllerState.of(context, listen: false);
  }

  @override
  void didUpdateWidget(covariant QuestionDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question.text == widget.question.text) {
      // Widget rebuilt after answer selection => no need to reset
      return;
    }
    this.setState(() {
      answered = false;
      selectedAnsInd = -1;
      timerKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/images/question_circle.svg",
                  width: 16,
                  color: Colors.grey[700],
                ),
                Text(
                  ' ${state.currQsInd + 1}/${state.numOfQuestions}',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: _difficultyBgColor(widget.question.difficulty),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
              child: Text(
                widget.question.difficulty.toString().substring(11),
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Text(
              'Score: ${state.score}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        TimeCircularCountdown(
          key: timerKey,
          unit: CountdownUnit.second,
          countdownTotal: 15,
          countdownCurrentColor: Colors.green,
          countdownRemainingColor: Colors.green,
          countdownTotalColor: Colors.grey[300],
          diameter: 75,
          textStyle: TextStyle(
              color: kPrimaryDark, fontSize: 18, fontWeight: FontWeight.bold),
          onFinished: () {
            setState(() {
              answered = true;
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.question.category,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.question.text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: kPrimaryDark, fontWeight: FontWeight.w500, fontSize: 27),
        ),
        const SizedBox(
          height: 20,
        ),
        ..._buildAnswers(),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            if (!state.hasNextQuestion) {
              Navigator.of(context).pushReplacementNamed('/end',
                  arguments: EndScreenArguments(
                    Score(state.score),
                    state.player,
                  ));
            } else {
              state.nextQuestion();
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: kPrimary,
            ),
            child: Text(
              _nextBtnText(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  String _nextBtnText() {
    if (!state.hasNextQuestion) {
      return "Finish Game";
    } else {
      return answered ? "Next Question" : "Skip This Question";
    }
  }

  _selectAnswer(int ansInd) {
    if (answered) {
      return;
    }
    setState(() {
      answered = true;
      selectedAnsInd = ansInd;
    });
    state.answer(ansInd);
  }

  _buildAnswers() {
    List<String> answers = widget.question.answers;
    return List.generate(
        answers.length,
        (index) => AnswerDisplay(
              text: answers[index],
              ind: index,
              select: _selectAnswer,
              isCorrect:
                  answered ? index == widget.question.correctAnswerInd : false,
              isSelected: index == selectedAnsInd,
            )).toList();
  }

  _difficultyBgColor(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.Hard:
        return Colors.red;
        break;
      case Difficulty.Medium:
        return Colors.amber;
      case Difficulty.Easy:
        return Colors.green;
      default:
        throw Exception("Invalid difficulty");
    }
  }
}
