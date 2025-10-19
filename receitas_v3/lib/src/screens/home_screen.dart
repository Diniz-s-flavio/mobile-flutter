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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receitas Favoritas'), backgroundColor: Colors.purple),
      drawer: const AppDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          RecipeCardsSection(title: 'Doces', recipes: SampleRecipes.doces),
          RecipeCardsSection(
            title: 'Salgadas',
            recipes: SampleRecipes.salgadas,
          ),
          RecipeCardsSection(title: 'Bebidas', recipes: SampleRecipes.bebidas),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.purple,
        indicatorColor: Color.fromARGB(156, 194, 0, 194),
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
          return const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          );
        }),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.cookie_outlined, color: Colors.white),
            label: 'Doces',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu, color: Colors.white),
            label: 'Salgadas',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_drink, color: Colors.white),
            label: 'Bebidas',
          ),
        ],
      ),
    );
  }
}
