import 'dart:convert';
import 'package:alkor_ecommerce_mt/models/cart_item.dart';
import 'package:alkor_ecommerce_mt/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;
  static const String cartKey = 'cart_items';
  static const String wishlistKey = 'wishlist_items';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveCart(List<CartItem> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    await _prefs.setString(cartKey, json.encode(jsonList));
  }

  static List<CartItem> loadCart() {
    final jsonString = _prefs.getString(cartKey);
    if (jsonString == null) return [];
    
    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => CartItem.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveWishlist(List<ProductModel> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    await _prefs.setString(wishlistKey, json.encode(jsonList));
  }

  static List<ProductModel> loadWishlist() {
    final jsonString = _prefs.getString(wishlistKey);
    if (jsonString == null) return [];
    
    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> clearAll() async {
    await _prefs.clear();
  }
}