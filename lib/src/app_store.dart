import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppStore extends ValueNotifier<AppLocale> {
  AppStore() : super(AppLocale.ptBR);

  void changeLocale(AppLocale newLocale) {
    if (newLocale != value) {
      value = newLocale;
    }
  }
}

enum AppLocale {
  ptBR('pt', 'BR'),
  enUS('en', 'US');

  const AppLocale(this._languageCode, this._countryCode);
  final String _languageCode;
  final String _countryCode;

  String get languageCode => _languageCode;
  String get countryCode => _countryCode;

  String get fullLanguageCode => '$_languageCode-${_countryCode.toUpperCase()}';
}
