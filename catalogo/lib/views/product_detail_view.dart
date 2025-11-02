import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_detail_viewmodel.dart';
import '../core/app_colors.dart';

class ProductDetailView extends StatelessWidget {
  final int productId;
  const ProductDetailView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductDetailViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: 'Voltar',
        ),
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(vm.errorMessage!, textAlign: TextAlign.center),
                  ),
                )
              : vm.product == null
                  ? const Center(child: Text('Produto não encontrado.'))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1.4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                color: AppColors.mid.withOpacity(0.2),
                                child: Image.network(
                                  vm.product!.imageUrl,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) =>
                                      const Center(child: Icon(Icons.image_not_supported, size: 48)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            vm.product!.title,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Chip(
                                label: Text(vm.product!.category),
                                backgroundColor: AppColors.mid.withOpacity(0.25),
                              ),
                              Text(
                                'US\$ ${vm.product!.price.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.accent,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (vm.product!.rating != null)
                            Row(
                              children: [
                                const Icon(Icons.star, size: 18),
                                const SizedBox(width: 4),
                                Text('${vm.product!.rating!.toStringAsFixed(1)}'
                                    '${vm.product!.ratingCount != null ? ' (${vm.product!.ratingCount})' : ''}'),
                              ],
                            ),
                          const SizedBox(height: 16),
                          Text(
                            'Descrição',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          Text(vm.product!.description),
                        ],
                      ),
                    ),
    );
  }
}
