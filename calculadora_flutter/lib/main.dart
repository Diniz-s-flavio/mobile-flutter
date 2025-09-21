import 'package:flutter/material.dart';
import 'calculadora.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 253, 173, 0),
          primary: const Color.fromARGB(255, 253, 173, 0),
        ),
        useMaterial3: true,
      ),
      home: const Calculadora(),
      debugShowCheckedModeBanner: false,
    );
  }
}
