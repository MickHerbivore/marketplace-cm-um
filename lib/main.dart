import 'package:flutter/material.dart';
import 'package:marketplace/routes/app_routes.dart';
import 'package:marketplace/services/auth_service.dart';
import 'package:marketplace/services/category_service.dart';
import 'package:marketplace/services/product_service.dart';
import 'package:marketplace/theme/my_theme.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ProductService()),
        ChangeNotifierProvider(create: (context) => CategoryService()),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marketplace',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerationRoute,
      theme: MyTheme.myTheme, 
    );
  }
}
