import 'package:flutter/material.dart';
import '../screens/settings_screen.dart';
import '../screens/about_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.purple,
      child: SafeArea(
        child: Column(
          children: [
            const ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: Icon(Icons.menu_book),
              title: Text('Receitas Favoritas'),
              subtitle: Text('Menu do aplicativo'),
            ),
            const Divider(),
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              },
            ),
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AboutScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
