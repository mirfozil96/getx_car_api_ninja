import 'package:get/get.dart';

import 'app_color.dart';

void showErrorAlert(String title, String desc) {

  Get.showSnackbar(GetSnackBar(
    title: title,
    message: desc,
    backgroundColor: AppColor.error60,
    duration: 3.seconds,
    snackPosition: SnackPosition.TOP,
  ));
}
