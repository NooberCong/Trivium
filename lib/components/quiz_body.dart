import 'package:flutter/material.dart';
import 'package:flutter_learn/application/game_controller.dart';
import 'package:flutter_learn/components/question_display.dart';
import 'package:flutter_learn/constants/colors.dart';
import 'package:flutter_learn/util/screen_size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animations/loading_animations.dart';

class QuizzBody extends StatelessWidget {
  const QuizzBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameControllerState gameState = GameControllerState.of(context);
    return Container(
      width: 700,
      constraints: BoxConstraints(
        minHeight: screenHeight(context, percentage: 60),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(
        child: _buildBody(gameState),
      ),
    );
  }

  _buildBody(GameControllerState state) {
    if (state.isLoading == true) {
      return Column(
        children: [
          LoadingBouncingGrid.square(
            backgroundColor: kPrimary,
            size: 60,
            inverted: true,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Loading...",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryDark,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      );
    } else if (state.loadFailed == true) {
      return Column(
        children: [
          SvgPicture.asset(
            "assets/images/warning.svg",
            color: kFailed,
            width: 60,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Failed to load questions, please check your internet connection",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kFailed,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          FlatButton(
              onPressed: state.reloadQuestions,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Reload ",
                    style: TextStyle(color: kPrimary, fontSize: 24),
                  ),
                  SvgPicture.asset(
                    "assets/images/reload.svg",
                    color: kPrimary,
                    width: 24,
                  ),
                ],
              ))
        ],
      );
    } else {
      return QuestionDisplay(
        question: state.currentQuestion,
      );
    }
  }
}
