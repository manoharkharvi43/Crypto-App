import 'dart:async';

class AppThemeStream {


  StreamController <bool>  _appThemeSC  = StreamController.broadcast();

  Stream <bool> get _appThemeStream   =>  _appThemeSC.stream;

}