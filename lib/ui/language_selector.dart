import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globalization_ex/controller/language_contrroller.dart';
import 'package:globalization_ex/di/di_container.dart';
import 'package:globalization_ex/model_mapper/translation_extension.dart';
import 'package:globalization_ex/ui/home_page.dart';

import '../shared/app_lanaguge_enums.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  AppLanguages _selectdLanguage = AppLanguages.english;

  @override
  void initState() {
    loadAsset();
    super.initState();
  }

  Future loadAsset() async {
    var rawText = await rootBundle.loadString('assets/translations/en-US.json');
    Map<String, dynamic> data = json.decode(rawText);
    final tranlatedText =
        await data.translateJson(translateLanguage: "marathi");
    print(tranlatedText.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Lanaguage"),
      ),
      body: Column(
        children: <Widget>[
          RadioListTile<AppLanguages>(
            title: const Text('english'),
            value: AppLanguages.english,
            groupValue: _selectdLanguage,
            onChanged: (AppLanguages? value) {
              if (value == null) {
                return;
              }
              setState(() {
                _selectdLanguage = value;
              });
            },
          ),
          RadioListTile<AppLanguages>(
            title: const Text('marathi'),
            value: AppLanguages.marathi,
            groupValue: _selectdLanguage,
            onChanged: (AppLanguages? value) {
              if (value == null) {
                return;
              }
              setState(() {
                _selectdLanguage = value;
              });
            },
          ),
          RadioListTile<AppLanguages>(
            title: const Text('hindi'),
            value: AppLanguages.hindi,
            groupValue: _selectdLanguage,
            onChanged: (AppLanguages? value) {
              if (value == null) {
                return;
              }
              setState(() {
                _selectdLanguage = value;
              });
            },
          ),
          RadioListTile<AppLanguages>(
            title: const Text('punjabi'),
            value: AppLanguages.punjabi,
            groupValue: _selectdLanguage,
            onChanged: (AppLanguages? value) {
              if (value == null) {
                return;
              }
              setState(() {
                _selectdLanguage = value;
              });
            },
          ),
          MaterialButton(
            onPressed: () {
              getIt<LangaugeController>().setAppLanguge(_selectdLanguage);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            },
            child: const Text("Go To app"),
          )
        ],
      ),
    );
  }
}
