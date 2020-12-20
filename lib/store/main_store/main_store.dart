import 'dart:ui';

import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_store.g.dart';

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {
  @observable
  Brightness brightness;

  @observable
  SharedPreferences prefs;

  Future toggleTheme() async {
    brightness =
        brightness == Brightness.light ? Brightness.dark : Brightness.light;
    await _updatePreferences();
  }

  Future _updatePreferences() async {
    await prefs.setBool("isDark", brightness == Brightness.dark);
    //print(prefs.getBool("isDark"));
  }
}
