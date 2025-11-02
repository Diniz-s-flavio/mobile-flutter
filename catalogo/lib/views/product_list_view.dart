import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_list_viewmodel.dart';
import '../viewmodels/product_detail_viewmodel.dart';
import '../data/services/product_service.dart';
import 'product_detail_view.dart';
import '../core/app_colors.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  void initState() {
    super.initState();
    // Carrega os produtos ao abrir a tela
    Future.microtask(() =>
        context.read<ProductListViewModel>().loadProducts());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductListViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo Online'),
      ),
      body: switch (vm.state) {
        ViewState.loading => const _Loading(),
        ViewState.error => _Error(message: vm.errorMessage ?? 'Erro desconhecido', onRetry: () {
          context.read<ProductListViewModel>().loadProducts();
        }),
        ViewState.idle => RefreshIndicator(
          onRefresh: () => context.read<ProductListViewModel>().loadProducts(),
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: vm.products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final p = vm.products[index];
              return Card(
                color: AppColors.primary.withOpacity(0.25),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      p.imageUrl,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                    ),
                  ),
                  title: Text(
                    p.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(p.category),
                  trailing: Text(
                    'US\$ ${p.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                        create: (_) => ProductDetailViewModel(ProductService())..load(p.id),
                        child: ProductDetailView(productId: p.id),
                      ),
                    ));
                  },
                ),
              );
            },
          ),
        ),
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _Error extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _Error({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 48),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
