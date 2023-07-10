import 'package:get_it/get_it.dart';
import 'package:globalization_ex/controller/language_contrroller.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<LangaugeController>(LangaugeController());
}
