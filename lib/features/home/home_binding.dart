// home_binding.dart
import 'package:get/get.dart';
import 'home_logic.dart';
import 'home_logic_impl.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeLogic>(() => HomeLogicImpl());
  }
}
