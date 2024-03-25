
import 'package:bloc_clean_architecture_tdd_solid/core/theme/theme.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/presentation/pages/login.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'inti.dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
 

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
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
