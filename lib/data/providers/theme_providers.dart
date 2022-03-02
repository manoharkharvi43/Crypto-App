import 'package:flutter/cupertino.dart';
import 'package:simple_flutter_app/constants.dart';

class ThemeProviders extends ChangeNotifier {
  Color themeColor = Constants.light_theme;
  Color light = Constants.light_theme;
  Color dark = Constants.dark_theme;
  bool isDarkmodeEnabled = false;

  void toogleTheme() {
    if (themeColor == light) {
      themeColor = dark;
      isDarkmodeEnabled = true;
    } else {
      themeColor = light;
      isDarkmodeEnabled = false;
    }
    notifyListeners();
  }
}
