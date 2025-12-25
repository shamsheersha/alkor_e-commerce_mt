import 'package:alkor_ecommerce_mt/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final ProductModel product;
  AddToCartEvent(this.product);
  
  @override
  List<Object?> get props => [product];
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;
  RemoveFromCartEvent(this.productId);
  
  @override
  List<Object?> get props => [productId];
}

class IncreaseQuantityEvent extends CartEvent {
  final int productId;
  IncreaseQuantityEvent(this.productId);
  
  @override
  List<Object?> get props => [productId];
}

class DecreaseQuantityEvent extends CartEvent {
  final int productId;
  DecreaseQuantityEvent(this.productId);
  
  @override
  List<Object?> get props => [productId];
}