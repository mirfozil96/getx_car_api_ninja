import 'package:get/get.dart';
import 'ru.dart';
import 'uz.dart';
import 'uz_cr.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'uz': uz,
        'ru': ru,
        'uz_cr': uzCr,
      };
}
