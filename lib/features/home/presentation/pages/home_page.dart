import 'package:flutter/material.dart';
import '../../../../core/config/env_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(EnvConfig.appName),
        backgroundColor: EnvConfig.isProduction 
            ? const Color(0xFF0D47A1) 
            : Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.rocket_launch, size: 100, color: Colors.blueAccent),
            const SizedBox(height: 20),
            const Text('Skeleton Project Siap!', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            Text('Base URL: ${EnvConfig.baseUrl}', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}