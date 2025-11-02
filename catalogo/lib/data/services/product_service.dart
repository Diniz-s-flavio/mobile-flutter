import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse('$_baseUrl/products');
    final resp = await http.get(uri).timeout(const Duration(seconds: 15));
    if (resp.statusCode == 200) {
      final List list = jsonDecode(resp.body) as List;
      return list.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Erro ao buscar produtos (${resp.statusCode}).');
  }

  Future<Product> fetchProductById(int id) async {
    final uri = Uri.parse('$_baseUrl/products/$id');
    final resp = await http.get(uri).timeout(const Duration(seconds: 15));
    if (resp.statusCode == 200) {
      return Product.fromJson(jsonDecode(resp.body) as Map<String, dynamic>);
    }
    throw Exception('Erro ao buscar produto #$id (${resp.statusCode}).');
  }
}
