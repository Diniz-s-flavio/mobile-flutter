import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/recipe_cards_section.dart';
import '../data/sample_recipes.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // 0: Doces, 1: Salgadas, 2: Bebidas


  final _pages = const [
  _CategoryTab(title: 'Doces'),
  _CategoryTab(title: 'Salgadas'),
  _CategoryTab(title: 'Bebidas'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas Favoritas'),
      ),
      drawer: const AppDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          RecipeCardsSection(title: 'Doces', recipes: SampleRecipes.doces),
          RecipeCardsSection(title: 'Salgadas', recipes: SampleRecipes.salgadas),
          RecipeCardsSection(title: 'Bebidas', recipes: SampleRecipes.bebidas),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.cookie_outlined), label: 'Doces'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu), label: 'Salgadas'),
          NavigationDestination(icon: Icon(Icons.local_drink), label: 'Bebidas'),
        ],
      ),
    );
  }
}


class _CategoryTab extends StatelessWidget {
final String title;
const _CategoryTab({required this.title});
@override
Widget build(BuildContext context) => Center(child: Text(title));
}