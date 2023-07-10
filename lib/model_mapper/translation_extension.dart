import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'dart:async';

extension MapTranslation on Map<String, dynamic> {
  Future<Map<String, dynamic>> translateJson(
      {required String translateLanguage}) async {
    try {
      //declartion based on selected languge
      final translator = OnDeviceTranslator(
          sourceLanguage: TranslateLanguage.english,
          targetLanguage: TranslateLanguage.values
              .firstWhere((lang) => lang.name == translateLanguage));

      //op var
      Map<String, dynamic> translatedJson = {};

      await Future.forEach(keys, (key) async {
        //
        final value = this[key];
        final translatedKey = await translator.translateText(key);

        //key is map
        if (value is Map<String, dynamic>) {
          var translatedValue =
              await value.translateJson(translateLanguage: translateLanguage);
          translatedJson[translatedKey] = translatedValue;
        } else {
          // plain key
          var translatedValue =
              await translator.translateText(value.toString());
          translatedJson[translatedKey] = translatedValue;
        }
      });

      return translatedJson;
    } catch (e) {
      return {"error": e.toString()};
    }
  }
}





/****************
 * 
 * 
 * code with respect to multitreding 
 *     isolate recive port
      final receivePort = ReceivePort();

      await Future.forEach(keys, (key) async {
        await compute(translateKey, {
          'translator': translator,
          'key': key,
          'receivePort': receivePort.sendPort,
        });
      });

      await for (final translatedKey in receivePort) {
        final value = this[translatedKey];
        print(value);

        if (value is Map<String, dynamic>) {
          final translatedValue =
              await value.translateJson(translateLanguage: translateLanguage);
          translatedJson[translatedKey] = translatedValue;
        } else {
          final translatedValue =
              await translator.translateText(value.toString());
          translatedJson[translatedKey] = translatedValue;
        }
      }

      receivePort.close();




void translateKey(Map<String, dynamic> data) {
  final translator = data['translator'] as OnDeviceTranslator;
  final key = data['key'] as String;

  final receivePort = data['receivePort'] as SendPort;

  translator.translateText(key).then((translatedKey) {
    log(key);
    receivePort.send(translatedKey);
  });
}
 */