import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_colors.dart';
import 'data/services/product_service.dart';
import 'viewmodels/product_list_viewmodel.dart';
import 'views/product_list_view.dart';

void main() {
  runApp(const CatalogoOnlineApp());
}

class CatalogoOnlineApp extends StatelessWidget {
  const CatalogoOnlineApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primary,
    ).copyWith(
      background: AppColors.dark,
      surface: AppColors.mid.withOpacity(0.2),
      secondary: AppColors.mid,
      tertiary: AppColors.accent,
      onTertiary: Colors.black,
    );

    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        surfaceTintColor: Colors.transparent,
        color: AppColors.mid.withOpacity(0.15),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accent,
      ),
      chipTheme: ChipThemeData(
        labelStyle: const TextStyle(color: Colors.white),
        side: BorderSide.none,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductListViewModel(ProductService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Catálogo Online',
        theme: theme,
        home: const ProductListView(),
      ),
    );
  }
}
