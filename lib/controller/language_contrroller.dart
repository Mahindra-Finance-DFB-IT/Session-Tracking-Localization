import 'package:globalization_ex/shared/app_lanaguge_enums.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class LangaugeController {
  final languageModelManager = OnDeviceTranslatorModelManager();

  AppLanguages _appLanguages = AppLanguages.english;

  AppLanguages get selectedAppLanague => _appLanguages;

  setAppLanguge(AppLanguages value) {
    _appLanguages = value;
  }

  Future downloadedLanguage({required AppLanguages appLanguages}) async {
    await languageModelManager.downloadModel(
        TranslateLanguage.values
            .firstWhere((element) =>
                element.name.toString() == appLanguages.name.toString())
            .bcpCode,
        isWifiRequired: false);
  }
}
