import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Ajustes gerais do aplicativo (mock).'),
        ),
      ),
    );
  }
}