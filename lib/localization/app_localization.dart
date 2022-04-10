import 'package:flutter/widgets.dart';
import 'package:flutter_boilerate_project/localization/dart_files/messages_all.dart';
import 'package:intl/intl.dart';

class AppLocalization {
  const AppLocalization(this.locale);

  final Locale locale;

  static AppLocalization? of(BuildContext context) =>
      Localizations.of<AppLocalization>(context, AppLocalization);
  static Future<AppLocalization> load(Locale locale) async {
    final localeName = Intl.canonicalizedLocale(locale.languageCode);
    // It produces an error now but it's fine; it will
    // disappear as soon as we use code generation to
    // create internationalization utilities
    await initializeMessages(localeName);
    // Setup intl to work with the device's locale
    Intl.defaultLocale = localeName;
    return AppLocalization(locale);
  }

  String get helloWorld => Intl.message(
        'Hello world!',
        name: 'helloWorld',
      );
  String get hello => Intl.message(
        'Hello',
        name: 'hello',
      );
}
