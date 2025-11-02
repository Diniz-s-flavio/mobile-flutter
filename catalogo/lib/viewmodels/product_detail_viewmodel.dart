import 'package:flutter/foundation.dart';
import '../data/models/product.dart';
import '../data/services/product_service.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final ProductService _service;
  ProductDetailViewModel(this._service);

  Product? _product;
  String? _errorMessage;
  bool _loading = false;

  Product? get product => _product;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _loading;

  Future<void> load(int id) async {
    _loading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _product = await _service.fetchProductById(id);
    } catch (e) {
      _errorMessage = 'Erro ao carregar detalhes do produto.';
      if (kDebugMode) _errorMessage = 'Erro ao carregar detalhes do produto. $e';
      _product = null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
