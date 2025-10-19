import 'package:flutter/material.dart';
import 'package:receitas_v1/src/data/sample_recipes.dart';
import 'recipe_detail_screen.dart';
import 'settings_screen.dart';
import 'about_screen.dart';
import 'add_recipe_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<String> _titles = [
    'Doces',
    'Salgadas',
    'Bebidas',
    'Favoritos',
  ];

  final List<Map<String, String>> favoritos = [];

  final List<Map<String, String>> doces = SampleRecipes.doces;

  final List<Map<String, String>> salgadas = SampleRecipes.salgadas;

  final List<Map<String, String>> bebidas = SampleRecipes.bebidas;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(Map<String, String> receita) {
    setState(() {
      if (favoritos.contains(receita)) {
        favoritos.remove(receita);
      } else {
        favoritos.add(receita);
      }
    });
  }

  Widget _buildRecipeList(List<Map<String, String>> receitas) {
    return ListView.builder(
      itemCount: receitas.length,
      itemBuilder: (context, index) {
        final receita = receitas[index];
        final isFavorite = favoritos.contains(receita);

        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            final receitaRemovida = receita;

            setState(() {
              receitas.removeAt(index);
              favoritos.remove(receitaRemovida);
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${receitaRemovida['titulo']} removida'),
                action: SnackBarAction(
                  label: 'Desfazer',
                  onPressed: () {
                    setState(() {
                      receitas.insert(index, receitaRemovida);
                    });
                  },
                ),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Icon(Icons.restaurant, size: 40, color: Colors.white),
              ),
              title: Text(receita['titulo']!),
              subtitle: Text(receita['descricao']!),
              trailing: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () => _toggleFavorite(receita),
              ),
              onTap: () async {
                final receitaEditada =
                    await Navigator.push<Map<String, String>?>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailScreen(
                          titulo: receita['titulo']!,
                          descricao: receita['descricao']!,
                          ingredientes: receita['ingredientes']!,
                          preparo: receita['preparo']!,
                          imagem: receita['imagem']!,
                        ),
                      ),
                    );

                if (receitaEditada != null) {
                  setState(() {
                    receitas[index] = {...receitas[index], ...receitaEditada};
                  });
                }
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _buildRecipeList(doces),
      _buildRecipeList(salgadas),
      _buildRecipeList(bebidas),
      _buildRecipeList(favoritos),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: Text('Menu', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sair'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cookie_outlined),
            label: 'Doces',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Salgadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Bebidas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final categoriaAtual = _titles[_selectedIndex] == 'Favoritos'
              ? 'Doces'
              : _titles[_selectedIndex];

          final novaReceita = await Navigator.push<Map<String, String>?>(
            context,
            MaterialPageRoute(
              builder: (_) => AddRecipeScreen(initialCategory: categoriaAtual),
            ),
          );

          if (novaReceita != null) {
            _adicionarReceita(novaReceita);

            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Receita "${novaReceita['titulo']}" adicionada em ${novaReceita['categoria']}',
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _adicionarReceita(Map<String, String> receita) {
    setState(() {
      switch (receita['categoria']) {
        case 'Doces':
          doces.add(receita);
          break;
        case 'Salgadas':
          salgadas.add(receita);
          break;
        case 'Bebidas':
          bebidas.add(receita);
          break;
        default:
          doces.add(receita);
      }
    });
  }
}
