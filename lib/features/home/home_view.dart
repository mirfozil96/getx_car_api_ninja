import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/manager/setting_contoller.dart';
import '../../localization/languages.dart';
import '../../ui/utils/app_color.dart';
import '../../ui/utils/app_typography.dart';
import '../../ui/widget/app_button.dart';
import '../../ui/widget/app_loader.dart';
import '../../ui/widget/app_text_field.dart';
import 'home_logic.dart';
import '../../core/repository/model/get_all_car_model.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  static const String route = "/home";
  HomePage({super.key});

  final HomeLogic logic = Get.find<HomeLogic>();
  final HomeState state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'home_title'.tr,
          style: AppTypography.title1.copyWith(color: AppColor.white),
        ),
        actions: [
          // Theme Switch
          Obx(
            () => Switch(
              value: settingsController.isDarkTheme.value,
              onChanged: (value) {
                settingsController.toggleTheme(value);
              },
              activeColor: AppColor.primary60,
              inactiveThumbColor: AppColor.basic60,
            ),
          ),
          // Language Dropdown
          Obx(
            () => DropdownButton<String>(
              value: settingsController.selectedLanguage.value,
              icon: const Icon(Icons.language, color: Colors.white),
              dropdownColor: Theme.of(context).primaryColor,
              items: appLanguages.map((language) {
                return DropdownMenuItem<String>(
                  value: language.symbol,
                  child: Text(
                    language.language,
                    style: AppTypography.bodyParagraph1
                        .copyWith(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  settingsController.changeLanguage(newValue);
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and filter UI
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Obx(() => DropdownButton<String>(
                              value: state.selectedParameter.value,
                              items: state.searchParameters
                                  .map((String parameter) {
                                return DropdownMenuItem<String>(
                                  value: parameter,
                                  child: Text(
                                    parameter,
                                    style: AppTypography.bodyParagraph1,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  state.selectedParameter.value = newValue;
                                }
                              },
                            )),
                        AppPrimaryButton(
                          text: "Add Filter".tr,
                          onTap: () {
                            final selectedParam = state.selectedParameter.value;
                            if (!state.activeFilters.contains(selectedParam)) {
                              state.activeFilters.add(selectedParam);
                              // Create a new controller if it doesn't exist
                              if (!state.filterControllers
                                  .containsKey(selectedParam)) {
                                state.filterControllers[selectedParam] =
                                    TextEditingController();
                              }
                              // Initialize selectedOptions if necessary
                              if (state.parameterOptions
                                  .containsKey(selectedParam)) {
                                state.selectedOptions.putIfAbsent(
                                    selectedParam,
                                    () => state.parameterOptions[selectedParam]!
                                        .first.obs);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Column(
                      children: [
                        Obx(() => DropdownButton<int>(
                              value: state.selectedLimit.value,
                              items: state.limitOptions.map((int limit) {
                                return DropdownMenuItem<int>(
                                  value: limit,
                                  child: Text(
                                    limit.toString(),
                                    style: AppTypography.bodyParagraph1,
                                  ),
                                );
                              }).toList(),
                              onChanged: (int? newValue) {
                                state.selectedLimit.value = newValue!;
                              },
                            )),
                        AppPrimaryButton(
                          text: "Search".tr,
                          onTap: () {
                            Map<String, String?> filters = {};
                            for (var key in state.activeFilters) {
                              // Check if controller exists
                              if (state.filterControllers.containsKey(key)) {
                                filters[key] =
                                    state.filterControllers[key]!.text;
                              }
                            }
                            logic.searchCars(
                              limit: state.selectedLimit.value,
                              filters: filters,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Obx(() {
                  return Wrap(
                    children: state.activeFilters.map((parameter) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 150,
                              child: _buildFilterWidget(parameter),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                state.activeFilters.remove(parameter);
                                // Dispose and remove the controller
                                state.filterControllers[parameter]?.dispose();
                                state.filterControllers.remove(parameter);
                                // Remove from selectedOptions if applicable
                                state.selectedOptions.remove(parameter);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
          // Car list
          Expanded(
            flex: 3,
            child: Obx(() {
              if (state.allCars.isEmpty) {
                if (state.noDataFound.value) {
                  // Display "No results found" message
                  return Center(
                    child: Text(
                      'no_results_found'.tr,
                      style: AppTypography.bodyParagraph1,
                    ),
                  );
                } else {
                  // Display loading indicator
                  return const Center(child: AppLoader());
                }
              } else {
                // Display list of cars
                return ListView.builder(
                  itemCount: state.allCars.length,
                  itemBuilder: (_, index) {
                    final car = state.allCars[index];
                    return _buildCarCard(car);
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterWidget(String parameter) {
    // Ensure the controller exists
    if (!state.filterControllers.containsKey(parameter)) {
      state.filterControllers[parameter] = TextEditingController();
    }

    if (state.parameterOptions.containsKey(parameter)) {
      // Ensure selectedOptions exists
      state.selectedOptions.putIfAbsent(
          parameter, () => state.parameterOptions[parameter]!.first.obs);

      return Obx(() {
        return DropdownButton<String>(
          value: state.selectedOptions[parameter]!.value,
          items: state.parameterOptions[parameter]!.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: AppTypography.bodyParagraph1,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              state.selectedOptions[parameter]!.value = newValue;
              state.filterControllers[parameter]!.text = newValue;
            }
          },
        );
      });
    } else {
      return AppTextField(
        controller: state.filterControllers[parameter],
        hintText: parameter,
      );
    }
  }

  Widget _buildCarCard(GetAllCarModel car) {
    return Card(
      color: AppColor.basic95,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Make: ${car.make ?? 'Unknown'}",
              style: AppTypography.bodyParagraph1,
            ),
            Text(
              "Model: ${car.model ?? 'Unknown'}",
              style: AppTypography.bodyParagraph1,
            ),
            Text(
              "Year: ${car.year ?? 'Unknown'}",
              style: AppTypography.bodyParagraph1,
            ),
            Text(
              "Fuel Type: ${car.fuelType?.toString() ?? 'Unknown'}",
              style: AppTypography.bodyParagraph1,
            ),
            Text(
              "Drive: ${car.drive ?? 'Unknown'}",
              style: AppTypography.bodyParagraph1,
            ),
            Text(
              "Cylinders: ${car.cylinders ?? 'Unknown'}",
              style: AppTypography.bodyParagraph1,
            ),
            Text(
              "Transmission: ${car.transmission?.toString() ?? 'Unknown'}",
              style: AppTypography.bodyParagraph1,
            ),
            Text(
              "City MPG: ${car.cityMpg ?? 'Unknown'}",
              style: AppTypography.bodyParagraph1,
            ),
            Text(
              "Highway MPG: ${car.highwayMpg ?? 'Unknown'}",
              style: AppTypography.bodyParagraph1,
            ),
            Text(
              "Combination MPG: ${car.combinationMpg ?? 'Unknown'}",
              style: AppTypography.bodyParagraph1,
            ),
          ],
        ),
      ),
    );
  }
}
