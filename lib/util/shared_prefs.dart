import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  // ignore: non_constant_identifier_names
  static SharedPreferences _INSTANCE;

  static init() async {
    if (_INSTANCE == null) {
      _INSTANCE = await SharedPreferences.getInstance();
    }
  }

  static SharedPreferences get instance => _INSTANCE;
}
