// home_logic.dart
import 'home_state.dart';

abstract class HomeLogic {
  final HomeState state = HomeState();

  Future<void> getData();
  void searchCars({Map<String, String?>? filters, int? limit});
}
