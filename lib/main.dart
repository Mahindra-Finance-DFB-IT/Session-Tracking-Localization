import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:globalization_ex/ui/language_selector.dart';

import 'di/di_container.dart';

/// ************* by easy localization translation + ml kit translation api */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupLocator();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('mr', 'IN'), // Marathi
        Locale('kn', 'IN'), // Kannada
      ],
      path: 'assets/translations', // Path to your language translations
      fallbackLocale: const Locale('en', 'US'), // Default language
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Localized App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LanguageSelector(),
    );
  }
}
