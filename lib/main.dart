import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/config/initial_binding.dart';
import 'core/config/routes.dart';
import 'core/manager/app_pref_storage.dart';
import 'core/manager/setting_contoller.dart';
import 'features/home/home_view.dart';
import 'localization/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(StorageManager(), permanent: true);
  Get.put(SettingsController(),
      permanent: true); // Initialize SettingsController
  runApp(const MyApp());
}
// main.dart (continuation)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Obx(
      () => StyledToast(
        locale: Locale(settingsController.selectedLanguage.value),
        alignment: Alignment.center,
        reverseAnimation: StyledToastAnimation.slideToBottomFade,
        toastAnimation: StyledToastAnimation.slideFromTopFade,
        toastPositions: const StyledToastPosition(align: Alignment.center),
        curve: Curves.fastOutSlowIn,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData(
            fontFamily: 'InterTight',
            brightness: Brightness.dark,
            // Define your dark theme here
          ),
          theme: ThemeData(
            fontFamily: 'InterTight',
            brightness: Brightness.light,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              surfaceTintColor: Colors.transparent,
              scrolledUnderElevation: 0,
            ),
          ),
          themeMode:
              settingsController.isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
          enableLog: true,
          getPages: routes,
          translations: AppTranslations(),
          locale: Locale(settingsController.selectedLanguage.value),
          fallbackLocale: const Locale('uz'),
          initialBinding: InitialBinding(),
          initialRoute: HomePage.route,
          builder: (context, child) => GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: child,
          ),
        ),
      ),
    );
  }
}

