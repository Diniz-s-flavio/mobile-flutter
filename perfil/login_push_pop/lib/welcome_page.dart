import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final String nome;
  const WelcomePage({super.key, required this.nome});

  String _saudacao() {
    final hora = DateTime.now().hour;
    if (hora < 12) return 'Bom dia';
    if (hora < 18) return 'Boa tarde';
    return 'Boa noite';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bem-vindo')),
      body: Center(
        child: Text(
          '${_saudacao()}, $nome!',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
