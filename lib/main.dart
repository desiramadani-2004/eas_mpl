import 'package:flutter/material.dart';
import 'core/di/injection.dart';
import 'core/routing/app_router.dart';
import 'core/config/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const FinalProjectApp());
}

class FinalProjectApp extends StatelessWidget {
  const FinalProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: !EnvConfig.isProduction,
      title: EnvConfig.appName, 
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: EnvConfig.isProduction 
            ? const Color(0xFF0D47A1)
            : Colors.teal,
      ),
      
      routerConfig: AppRouter.router,
    );
  }
}