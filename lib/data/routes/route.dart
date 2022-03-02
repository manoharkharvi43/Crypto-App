import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter_app/presentation/pages/auth_pages/get_started_page.dart';
import 'package:simple_flutter_app/presentation/pages/auth_pages/login_page.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/Settings.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/all_crypto_screen/all_cryptos_screen.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/bottom_tab.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/charts/crypto_chart.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/dashboard.dart';

class Routes {
  static const String homePage = "home";
  static const String login = "login";
  static const String setting = "settings";
  static const String dashboard = "dashboard";
  static const String all_crypto_screen = "allCryptoScreen";
  static const String get_started = "get_started";
  static const String crypto_charts = "crypto_charts";

  static Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homePage:
        return MaterialPageRoute(builder: (context) => DashBoard());
      case Routes.setting:
        return MaterialPageRoute(builder: (context) => Settings());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (context) => BottomTabNav());
      case Routes.all_crypto_screen:
        return MaterialPageRoute(builder: (context) => AllCryptoScreen());
      case Routes.get_started:
        return MaterialPageRoute(builder: (context) => GetStarted());
      case Routes.crypto_charts:
        return MaterialPageRoute(builder: (context) => Charts());
      default:
        throw ("this route doesn't exist");
    }
  }
}
