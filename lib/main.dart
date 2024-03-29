import 'package:bloc_clean_architecture_tdd_solid/core/theme/theme.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/presentation/pages/login.page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture with Bloc and SOLID',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
