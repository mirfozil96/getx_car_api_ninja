// home_state.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../core/repository/model/get_all_car_model.dart';

class HomeState {
  // State variables
  var allCars = <GetAllCarModel>[].obs;
  var limit = 10.obs; // default limit
  var page = 0.obs;
 var noDataFound = false.obs;
  // Parameters
  Map<String, String?> filters = {};
  Map<String, RxString> selectedOptions = {};
  // UI variables
  var selectedParameter = 'make'.obs;
  var selectedLimit = 10.obs;

  final Map<String, TextEditingController> filterControllers = {
    'make': TextEditingController(),
    'model': TextEditingController(),
    'year': TextEditingController(),
    'fuel_type': TextEditingController(),
    'drive': TextEditingController(),
    'cylinders': TextEditingController(),
    'transmission': TextEditingController(),
    'min_city_mpg': TextEditingController(),
    'max_city_mpg': TextEditingController(),
    'min_hwy_mpg': TextEditingController(),
    'max_hwy_mpg': TextEditingController(),
    'min_comb_mpg': TextEditingController(),
    'max_comb_mpg': TextEditingController(),
  };

  final List<String> searchParameters = [
    'make',
    'model',
    'year',
    'fuel_type',
    'drive',
    'cylinders',
    'transmission',
    'min_city_mpg',
    'max_city_mpg',
    'min_hwy_mpg',
    'max_hwy_mpg',
    'min_comb_mpg',
    'max_comb_mpg',
  ];

  final List<int> limitOptions = [5, 10, 20, 50];

  final Map<String, List<String>> parameterOptions = {
    'fuel_type': ['gas', 'diesel', 'electricity'],
    'drive': ['fwd', 'rwd', 'awd', '4wd'],
    'cylinders': ['2', '3', '4', '5', '6', '8', '10', '12', '16'],
    'transmission': ['m', 'a'],
  };

  var activeFilters = <String>[].obs;

  HomeState() {
    /// Initialize variables if necessary
    parameterOptions.forEach((key, value) {
      selectedOptions[key] = value.first.obs;
    });
  }

  // Dispose controllers when not needed
  void dispose() {
    filterControllers.forEach((key, controller) {
      controller.dispose();
    });
  }
}
