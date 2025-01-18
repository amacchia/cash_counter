import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const CashCounterApp());
}

class CashCounterApp extends StatelessWidget {
  const CashCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Cash Counter'),
        ),
        body: Center(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
