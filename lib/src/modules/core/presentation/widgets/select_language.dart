import 'package:flutter/material.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/app_store.dart';

import '../../../../core/core.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  late AppLocale _currentValue;
  late AppStore _appStore;

  @override
  void initState() {
    super.initState();
    _appStore = serviceLocator.get<AppStore>();
    _currentValue = _appStore.value;
  }

  @override
  Widget build(BuildContext context) {
    const List<AppLocale> locales = AppLocale.values;
    return DropdownButton<AppLocale>(
      icon: const Icon(Icons.translate),
      value: _currentValue,
      items: locales
          .map<DropdownMenuItem<AppLocale>>((locale) => DropdownMenuItem(
              value: locale,
              child: LabelAtom(
                text: locale.fullLanguageCode,
              )))
          .toList(),
      onChanged: (value) {
        setState(() {
          _currentValue = value ?? AppLocale.ptBR;
        });
        _appStore.changeLocale(_currentValue);
      },
    );
  }
}
