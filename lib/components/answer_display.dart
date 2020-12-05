import 'package:flutter/material.dart';
import 'package:flutter_learn/constants/colors.dart';

enum AnswerState { Unselected, Correct, Incorrect }

class AnswerDisplay extends StatelessWidget {
  const AnswerDisplay({
    Key key,
    @required this.text,
    @required this.ind,
    @required this.select,
    @required this.isCorrect,
    @required this.isSelected,
  }) : super(key: key);
  final String text;
  final int ind;
  final Function select;
  final bool isCorrect;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    AnswerState state = _answerState(ind);
    return GestureDetector(
      onTap: () => select(ind),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.5),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: _borderFromState(state),
          borderRadius: BorderRadius.circular(10),
          color: _colorFromState(state),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: _textColorFromState(state),
          ),
        ),
      ),
    );
  }

  Color _textColorFromState(AnswerState state) {
    return state == AnswerState.Unselected ? kPrimaryDark : Colors.white;
  }

  Border _borderFromState(AnswerState state) {
    return state == AnswerState.Unselected
        ? Border.all(width: 2, color: Colors.grey[400])
        : Border.all(width: 2, color: Colors.transparent);
  }

  Color _colorFromState(AnswerState state) {
    return state == AnswerState.Unselected
        ? Colors.transparent
        : state == AnswerState.Correct
            ? kSuccess
            : kFailed;
  }

  AnswerState _answerState(int ind) {
    if (!isSelected && !isCorrect) {
      return AnswerState.Unselected;
    } else {
      return isCorrect ? AnswerState.Correct : AnswerState.Incorrect;
    }
  }
}
