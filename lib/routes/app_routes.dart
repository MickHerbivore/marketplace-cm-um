import 'package:flutter/material.dart';

import '../screen/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'add_user': (BuildContext context) => const RegisterUserScreen(),
    'list': (BuildContext context) => const ListProductScreen(),
    'edit': (BuildContext context) => const EditProductScreen(),
  };

  static Route<dynamic> onGenerationRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen()
    );
  }
}