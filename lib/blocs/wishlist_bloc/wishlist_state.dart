import 'package:alkor_ecommerce_mt/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class WishlistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductModel> items;
  
  WishlistLoaded(this.items);
  
  bool isInWishlist(int productId) {
    return items.any((item) => item.id == productId);
  }
  
  @override
  List<Object?> get props => [items];
}