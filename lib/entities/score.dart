import 'package:flutter_learn/util/shared_prefs.dart';

const SCORE_KEY = "best_score";

class Score {
  final int value;

  static Score get best {
    return Score(SharedPrefsHelper.instance.containsKey(SCORE_KEY)
        ? SharedPrefsHelper.instance.getInt(SCORE_KEY)
        : 0);
  }

  void save() {
    SharedPrefsHelper.instance.setInt(SCORE_KEY, value);
  }

  Score(this.value);
}
