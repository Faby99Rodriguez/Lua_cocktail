import 'package:cocktail/providers/cock_provider.dart';
import 'package:cocktail/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(apiService: apiService),
    );
  }
}
