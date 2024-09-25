import 'package:flutter/cupertino.dart';

import '../utils/app_color.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      animating: true,
      color: AppColor.white,
      radius: 12,
    );
  }
}
