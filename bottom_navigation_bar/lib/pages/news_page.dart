import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const nome = 'Fravo';
    final manchetes = const [
      'Manchete Fiticsia 1',
      'Machete Ficticia 2',
      'Manchete Ficticia 3',
      'Machete Fiticsia 4',
      'Manchete Ficticia 5',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Notícias')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 12),
              // Lista de manchetes
              ...manchetes.map(
                (m) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.article),
                    title: Text(m),
                    subtitle: const Text('Fonte: Jornal Fictício'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
