import 'package:alkor_ecommerce_mt/models/cart_item.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  
  CartLoaded(this.items);
  
  double get totalPrice => items.fold(0, (sum, item) => sum + item.totalPrice);
  
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  
  @override
  List<Object?> get props => [items];
}
