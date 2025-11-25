import 'package:flutter/material.dart';
import 'package:quick_service/screens/provider_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickService',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Our app's green color
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
        ),
        useMaterial3: true,
      ),
      home: const ProviderListScreen(),
    );
  }
}

