import 'dart:convert';

import 'package:alkor_ecommerce_mt/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const baseUrl = 'https://fakestoreapi.com';

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('Network error $e');
    }
  }
}
