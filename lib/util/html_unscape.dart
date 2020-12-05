import 'package:html_unescape/html_unescape_small.dart';

var _unescape = HtmlUnescape();

String unescape(String input) {
  return _unescape.convert(input);
}
