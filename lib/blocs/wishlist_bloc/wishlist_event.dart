import 'package:alkor_ecommerce_mt/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class WishlistEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadWishListEvent extends WishlistEvent{}

class AddToWishListEvent extends WishlistEvent{
  final ProductModel product;

  AddToWishListEvent(this.product);

  @override 
  List<Object?> get props => [product];
}

class RemoveFromWishlistEvent extends WishlistEvent {
  final int productId;
  RemoveFromWishlistEvent(this.productId);
  
  @override
  List<Object?> get props => [productId];
}

class ToggleWishlistEvent extends WishlistEvent {
  final ProductModel product;
  ToggleWishlistEvent(this.product);
  
  @override
  List<Object?> get props => [product];
}