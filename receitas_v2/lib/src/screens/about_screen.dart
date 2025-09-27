import 'package:flutter/material.dart';


class AboutScreen extends StatelessWidget {
  static const routeName = '/about';
  const AboutScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'App de Receitas Favoritas — exemplo didático de navegação por abas, '
          'detalhes e menu lateral (Drawer).',
        ),
      ),
    );
  }
}