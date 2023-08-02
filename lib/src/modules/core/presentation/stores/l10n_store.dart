import 'package:flutter/material.dart';

enum AppLocale {
  ptBR(Locale('pt', 'BR')),
  enUS(Locale('en', 'US'));

  final Locale _locale;
  const AppLocale(this._locale);
  Locale get locale => _locale;
  String get localeString => locale.toLanguageTag();
}

class LocaleStore extends ValueNotifier<AppLocale> {
  LocaleStore(super.value);

  void setLocale(AppLocale newLocale) {
    value = newLocale;
    notifyListeners();
  }
}

class InheritedLocale extends InheritedNotifier<LocaleStore> {
  const InheritedLocale({
    super.key,
    required super.child,
    required super.notifier,
  });

  @override
  bool updateShouldNotify(covariant InheritedLocale oldWidget) {
    return oldWidget.notifier?.value._locale != notifier?.value.locale;
  }

  static InheritedLocale? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedLocale>();
  }
}
