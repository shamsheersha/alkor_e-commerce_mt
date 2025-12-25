import 'package:alkor_ecommerce_mt/blocs/cart_bloc/cart_event.dart';
import 'package:alkor_ecommerce_mt/blocs/cart_bloc/cart_state.dart';
import 'package:alkor_ecommerce_mt/models/cart_item.dart';
import 'package:alkor_ecommerce_mt/services/storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<IncreaseQuantityEvent>(_onIncreaseQuantity);
    on<DecreaseQuantityEvent>(_onDecreaseQuantity);
  }

  void _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) {
    final items = StorageService.loadCart();
    emit(CartLoaded(items));
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final currentItems = List<CartItem>.from((state as CartLoaded).items);
      final existingIndex = currentItems.indexWhere(
        (item) => item.product.id == event.product.id,
      );

      if (existingIndex >= 0) {
        currentItems[existingIndex] = currentItems[existingIndex].copyWith(
          quantity: currentItems[existingIndex].quantity + 1,
        );
      } else {
        currentItems.add(CartItem(product: event.product, quantity: 1));
      }

      await StorageService.saveCart(currentItems);
      emit(CartLoaded(currentItems));
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final currentItems = List<CartItem>.from((state as CartLoaded).items);
      currentItems.removeWhere((item) => item.product.id == event.productId);
      
      await StorageService.saveCart(currentItems);
      emit(CartLoaded(currentItems));
    }
  }

  Future<void> _onIncreaseQuantity(
    IncreaseQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final currentItems = List<CartItem>.from((state as CartLoaded).items);
      final index = currentItems.indexWhere(
        (item) => item.product.id == event.productId,
      );

      if (index >= 0) {
        currentItems[index] = currentItems[index].copyWith(
          quantity: currentItems[index].quantity + 1,
        );
        await StorageService.saveCart(currentItems);
        emit(CartLoaded(currentItems));
      }
    }
  }

  Future<void> _onDecreaseQuantity(
    DecreaseQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final currentItems = List<CartItem>.from((state as CartLoaded).items);
      final index = currentItems.indexWhere(
        (item) => item.product.id == event.productId,
      );

      if (index >= 0) {
        if (currentItems[index].quantity > 1) {
          currentItems[index] = currentItems[index].copyWith(
            quantity: currentItems[index].quantity - 1,
          );
          await StorageService.saveCart(currentItems);
          emit(CartLoaded(currentItems));
        }
      }
    }
  }
}