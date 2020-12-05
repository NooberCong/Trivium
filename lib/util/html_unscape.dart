import 'package:html_unescape/html_unescape.dart';

var _unescape = HtmlUnescape();

String unescape(String input) {
  return _unescape.convert(input);
}
