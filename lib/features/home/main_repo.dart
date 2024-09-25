// main_repo.dart
import 'dart:developer';

import '../../core/api/api.dart';
import '../../core/api/api_constants.dart';
import '../../core/repository/model/get_all_car_model.dart';

// main_repo.dart
class MainRepo {
  Future<List<GetAllCarModel>?> getAllCars({
    required int limit,
    Map<String, String?>? filters,
  }) async {
    try {
      String api = ApiConstants.apiGetAllImages;
      Map<String, String> params = {
        'limit': limit.toString(),
      };

      if (filters != null) {
        filters.forEach((key, value) {
          if (value != null && value.isNotEmpty) {
            params[key] = value;
          }
        });
      }

      String? result = await Api.get(api, params);
      if (result != null && result.isNotEmpty) {
        List<GetAllCarModel> getAllCarModels = getAllCarModelFromJson(result);
        return getAllCarModels;
      } else {
        // Return an empty list to indicate no data
        return [];
      }
    } catch (e) {
      // Handle exceptions
      log('Error fetching cars: $e');
      return [];
    }
  }
}
