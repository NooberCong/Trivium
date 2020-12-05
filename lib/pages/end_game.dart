import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/constants/colors.dart';
import 'package:flutter_learn/entities/score.dart';
import 'package:flutter_learn/util/screen_size.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EndScreenArguments {
  final Score score;
  final String player;

  EndScreenArguments(this.score, this.player);
}

class EndScreen extends StatefulWidget {
  final EndScreenArguments arguments;
  const EndScreen({Key key, this.arguments}) : super(key: key);

  @override
  _EndScreenState createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  Score bestScore;

  @override
  void initState() {
    super.initState();
    bestScore = Score.best;
    if (widget.arguments.score.value > bestScore.value) {
      // Save new best score
      widget.arguments.score.save();
      bestScore = Score.best;
    }
  }

  ConfettiController _controller = ConfettiController(
    duration: const Duration(
      seconds: 10,
    ),
  );
  @override
  Widget build(BuildContext context) {
    _controller.play();
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: kSuccess,
        ),
        child: Center(
          child: Container(
            width: screenWidth(context, percentage: 80),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConfettiWidget(
                  confettiController: _controller,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: true,
                ),
                SvgPicture.asset(
                  "assets/images/trophy.svg",
                  width: 120,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Congratulations ${widget.arguments.player}!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kPrimaryDark,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Your score: ${widget.arguments.score.value}",
                  style: TextStyle(
                    color: kPrimaryDark,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Best score: ${bestScore.value}",
                  style: TextStyle(
                    color: kPrimaryDark,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kPrimary,
                    ),
                    child: Text(
                      "Play again",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
