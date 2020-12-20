// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainStore on _MainStore, Store {
  final _$brightnessAtom = Atom(name: '_MainStore.brightness');

  @override
  Brightness get brightness {
    _$brightnessAtom.reportRead();
    return super.brightness;
  }

  @override
  set brightness(Brightness value) {
    _$brightnessAtom.reportWrite(value, super.brightness, () {
      super.brightness = value;
    });
  }

  final _$prefsAtom = Atom(name: '_MainStore.prefs');

  @override
  SharedPreferences get prefs {
    _$prefsAtom.reportRead();
    return super.prefs;
  }

  @override
  set prefs(SharedPreferences value) {
    _$prefsAtom.reportWrite(value, super.prefs, () {
      super.prefs = value;
    });
  }

  @override
  String toString() {
    return '''
brightness: ${brightness},
prefs: ${prefs}
    ''';
  }
}
