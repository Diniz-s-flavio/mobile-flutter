import 'package:flutter/foundation.dart';
import '../data/models/product.dart';
import '../data/services/product_service.dart';

enum ViewState { idle, loading, error }

class ProductListViewModel extends ChangeNotifier {
  final ProductService _service;
  ProductListViewModel(this._service);

  ViewState _state = ViewState.idle;
  String? _errorMessage;
  List<Product> _products = [];

  ViewState get state => _state;
  String? get errorMessage => _errorMessage;
  List<Product> get products => _products;

  Future<void> loadProducts() async {
    _state = ViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await _service.fetchProducts();
      _state = ViewState.idle;
    } catch (e) {
      _state = ViewState.error;
      _errorMessage = 'Não foi possível carregar os produtos. Verifique sua conexão e tente novamente.';
      if (kDebugMode) _errorMessage = _errorMessage! + '\nDetalhes: $e';
    }
    notifyListeners();
  }
}
