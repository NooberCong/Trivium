import 'package:flutter/material.dart';

double screenWidth(BuildContext context, {double percentage = 100}) {
  return MediaQuery.of(context).size.width / 100 * percentage;
}

double screenHeight(BuildContext context, {double percentage = 100}) {
  return MediaQuery.of(context).size.height / 100 * percentage;
}

