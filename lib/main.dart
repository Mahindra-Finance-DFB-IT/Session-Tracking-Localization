import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

/// ************* by easy localization translation + ml kit translation api */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: TranslateLanguage.marathi);
  bool isRequiredModelDownloaded = false;

  @override
  void dispose() {
    onDeviceTranslator.close();
    super.dispose();
  }

  @override
  void initState() {
    _checkDownloadedModels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('app_title').tr(), // Localized app title
        actions: [
          PopupMenuButton<Locale>(
            onSelected: (locale) {
              context.setLocale(locale);
            },
            itemBuilder: (BuildContext context) => const [
              PopupMenuItem(
                value: Locale('en', 'US'),
                child: Text('English'),
              ),
              PopupMenuItem(
                value: Locale('mr', 'IN'),
                child: Text('Marathi'),
              ),
              PopupMenuItem(
                value: Locale('kn', 'IN'),
                child: Text('Kannada'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('api_data', style: TextStyle(fontSize: 20))
                .tr(), // Localized label

            const SizedBox(height: 20),

            FutureBuilder<Map<String, dynamic>>(
              future: _fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error fetching user data!');
                } else if (snapshot.hasData) {
                  final userData = snapshot.data!;

                  return Column(
                    children: [
                      Text('user_id: ${userData['user_id']}'),
                      Text('name: ${userData['name']}'),
                      Text('email: ${userData['email']}'),
                      Text('phone: ${userData['phone']}'),
                      Text('address: ${userData['address']}'),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "data using NLP ML kit tranlation API",
              style: TextStyle(fontSize: 20),
            ),

            FutureBuilder<Map<String, dynamic>>(
              future: _translateUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  final userData = snapshot.data!;

                  return Column(
                    children: [
                      Text('user_id: ${userData['user_id']}'),
                      Text('name: ${userData['name']}'),
                      Text('email: ${userData['email']}'),
                      Text('city: ${userData['city']}'),
                      Text('address: ${userData['address']}'),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _checkDownloadedModels() async {
    final modelManager = OnDeviceTranslatorModelManager();
    final bool engModelRes =
        await modelManager.isModelDownloaded(TranslateLanguage.english.bcpCode);
    final bool marModelRes =
        await modelManager.isModelDownloaded(TranslateLanguage.marathi.bcpCode);
    log("------------------- eng model res $engModelRes");
    log("------------------- mar model res $marModelRes");
    if (!marModelRes) {
      log("---------------- installing marathi model");
      final bool marDownloadModel = await modelManager.downloadModel(
          TranslateLanguage.marathi.bcpCode,
          isWifiRequired: false);
      log("------------------- mar model has been downloaded $marDownloadModel");
      isRequiredModelDownloaded = marDownloadModel;
      setState(() {});
    }
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    // Simulate API request delay
    await Future.delayed(const Duration(seconds: 1));

    // dummy data of the user
    return {
      'user_id': '12345',
      'name': tr('user.name'),
      'email': tr('user.email'),
      'phone': tr('user.phone'),
      'address': tr('user.address'),
    };
  }

  Future<Map<String, dynamic>> _translateUserData() async {
    // Simulate API request delay
    await Future.delayed(const Duration(seconds: 1));
    final mlTr = onDeviceTranslator.translateText;

    print("-------------------------------${await mlTr('raviraj')}");

    // dummy data of the user
    return {
      'user_id': '12345',
      'name': await mlTr('raviraj'),
      'email': await mlTr('ravi@mail.to'),
      'city': await mlTr('mumbai'),
      'address': await mlTr('Vikhroli, Godrej Park'),
    };
  }
}
