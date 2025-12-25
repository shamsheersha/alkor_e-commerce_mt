import 'dart:developer';

import 'package:alkor_ecommerce_mt/blocs/product_bloc/product_event.dart';
import 'package:alkor_ecommerce_mt/blocs/product_bloc/product_state.dart';
import 'package:alkor_ecommerce_mt/models/product_model.dart';
import 'package:alkor_ecommerce_mt/services/api_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiServices apiServices;
  List<ProductModel> allProducts = [];
  ProductBloc(this.apiServices) : super(ProductInitial()) {
    on<FetchProductsEvent>(onFetchProducts);
    on<SearchProductEvent>(onSearchProducts);
    on<FilterbyCategoryEvent>(onFilterByCategory);
  }
  Future onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    try {
      final products = await apiServices.fetchProducts();
      allProducts = products;
      emit(ProductLoaded(products: products, filteredProducts: products));
    } catch (e) {
      log(e.toString());
      emit(ProductError(message: e.toString()));
    }
  }

  void onSearchProducts(
    SearchProductEvent event,
    Emitter<ProductState> emit,
  ) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final query = event.query.toLowerCase();

      if (query.isEmpty) {
        emit(
          ProductLoaded(
            products: allProducts,
            filteredProducts: currentState.selectedCategory != null
                ? allProducts
                      .where((p) => p.category == currentState.selectedCategory)
                      .toList()
                : allProducts,
            selectedCategory: currentState.selectedCategory,
          ),
        );
      }else {
        final baseList = currentState.selectedCategory != null? 
        allProducts.where((p)=> p.category == currentState.selectedCategory).toList() : allProducts;

        final filtered = baseList.where((product){
          return product.title.toLowerCase().contains(query) || product.category.toLowerCase().contains(query);
        }).toList();
        emit(ProductLoaded(products: allProducts, filteredProducts: filtered,selectedCategory: currentState.selectedCategory));
      }
    }
  }

  void onFilterByCategory(
    FilterbyCategoryEvent event,
    Emitter<ProductState> emit,
  ) {
    if (state is ProductLoaded) {
      final filtered = event.category == null
          ? allProducts
          : allProducts.where((p) => p.category == event.category).toList();
      
      emit(ProductLoaded(
        products: allProducts,
        filteredProducts: filtered,
        selectedCategory: event.category,
      ));
    }
  }
}
