import 'package:flutter/material.dart';
import 'package:flutter_learn/constants/colors.dart';
import 'package:flutter_learn/pages/in_game.dart';
import 'package:flutter_learn/util/screen_size.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  TextEditingController _controller;
  FocusNode _node;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _node = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Trivium",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 66,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                "assets/images/question.svg",
                color: Colors.white,
                height: screenHeight(context, percentage: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: screenWidth(context, percentage: 80),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        focusNode: _node,
                        controller: _controller,
                        decoration: InputDecoration(
                            labelText: "Your name",
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ),
                            border: InputBorder.none,
                            hintText: 'Player'),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "/game",
                                arguments: GameScreenArguments(
                                    _controller.text.isNotEmpty
                                        ? _controller.text
                                        : "Player"),
                              );
                              _node.unfocus();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kPrimaryDark,
                              ),
                              child: Text(
                                "Start game",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("/settings");
                            _node.unfocus();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kPrimaryDark,
                            ),
                            child: SvgPicture.asset(
                              "assets/images/settings.svg",
                              width: 21,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _node.dispose();
    super.dispose();
  }
}
