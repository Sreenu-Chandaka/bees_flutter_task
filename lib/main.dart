import 'package:bees_flutter_task/screens/receipts_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transport Management',
      theme: ThemeData(
        primaryColor: const Color(0xFF2196F3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2196F3),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: ReceiptsScreen(),
    );
  }
}
