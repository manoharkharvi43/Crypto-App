import 'package:flutter/cupertino.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/Settings.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/all_crypto_screen/all_cryptos_screen.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/dashboard.dart';

class MainAuthPages {
  static List<Widget> main_auth_pages = [
    DashBoard(
      key: PageStorageKey('DashBoard'),
    ),
    AllCryptoScreen(
      key: PageStorageKey('AllCryptoScreen'),
    ),
    Settings(
      key: PageStorageKey('Settings'),
    ),
  ];
}
