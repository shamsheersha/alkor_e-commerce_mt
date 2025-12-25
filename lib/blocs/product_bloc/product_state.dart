import 'package:alkor_ecommerce_mt/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final List<ProductModel> filteredProducts;
  final String? selectedCategory;

  ProductLoaded({required this.products,required this.filteredProducts,this.selectedCategory});

  @override
  List<Object?> get props => [products,filteredProducts,selectedCategory];
}

class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});

  @override
  List<Object?> get props => [message];
}