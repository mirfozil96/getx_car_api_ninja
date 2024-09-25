import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../features/home/home_binding.dart';
import '../../features/home/home_view.dart';

final List<GetPage> routes = [


  GetPage(
    name: HomePage.route,
    page: () => HomePage(),
    binding: HomeBinding(),
  ),
 
];
