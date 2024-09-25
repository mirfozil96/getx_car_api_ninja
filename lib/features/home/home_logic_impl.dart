// home_logic_impl.dart
import 'package:get/get.dart';
import 'home_logic.dart';
import '../../core/repository/model/get_all_car_model.dart';
import 'home_state.dart';
import 'main_repo.dart';

class HomeLogicImpl extends GetxController implements HomeLogic {
  @override
  final HomeState state = HomeState();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  Future<void> getData() async {
    // Indicate that loading has started
    state.noDataFound.value = false;

    List<GetAllCarModel>? newCars = await MainRepo().getAllCars(
      limit: state.limit.value,
      filters: state.filters,
    );

    if (newCars == null || newCars.isEmpty) {
      // No data was returned
      state.noDataFound.value = true;
    } else {
      // Data was found
      state.allCars.addAll(newCars);
    }
  }

  @override
  void searchCars({Map<String, String?>? filters, int? limit}) async {
    state.filters = filters ?? state.filters;
    state.limit.value = limit ?? state.limit.value;
    state.allCars.clear();
    state.noDataFound.value = false; // Reset noDataFound before new search

    await getData();
  }

  @override
  void dispose() {
    state.dispose(); // Dispose controllers
    super.dispose();
  }
}
