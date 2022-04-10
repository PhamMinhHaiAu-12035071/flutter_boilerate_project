import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerate_project/localization/app_localization.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
