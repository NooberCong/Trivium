import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/constants/colors.dart';

class CountDownTimer {
  static Widget getDynamic(int total, Function onFinished) {
    return TimeCircularCountdown(
      key: UniqueKey(),
      unit: CountdownUnit.second,
      countdownTotal: total,
      countdownCurrentColor: Colors.green,
      countdownRemainingColor: Colors.green,
      countdownTotalColor: Colors.grey[300],
      diameter: 75,
      textStyle: TextStyle(
          color: kPrimaryDark, fontSize: 18, fontWeight: FontWeight.bold),
      onFinished: onFinished,
    );
  }

  static Widget getStatic(int total) {
    return CircularCountdown(
      countdownTotal: total,
      countdownCurrentColor: Colors.green,
      countdownRemainingColor: Colors.green,
      countdownTotalColor: Colors.grey[300],
      diameter: 75,
      textStyle: TextStyle(
          color: kPrimaryDark, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
