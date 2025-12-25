import 'package:alkor_ecommerce_mt/blocs/wishlist_bloc/wishlist_event.dart';
import 'package:alkor_ecommerce_mt/blocs/wishlist_bloc/wishlist_state.dart';
import 'package:alkor_ecommerce_mt/models/product_model.dart';
import 'package:alkor_ecommerce_mt/services/storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<LoadWishListEvent>(_onLoadWishlist);
    on<AddToWishListEvent>(_onAddToWishlist);
    on<RemoveFromWishlistEvent>(_onRemoveFromWishlist);
    on<ToggleWishlistEvent>(_onToggleWishlist);
  }

  void _onLoadWishlist(LoadWishListEvent event, Emitter<WishlistState> emit) {
    final items = StorageService.loadWishlist();
    emit(WishlistLoaded(items));
  }

  Future<void> _onAddToWishlist(
    AddToWishListEvent event,
    Emitter<WishlistState> emit,
  ) async {
    if (state is WishlistLoaded) {
      final currentItems = List<ProductModel>.from((state as WishlistLoaded).items);
      
      if (!currentItems.any((item) => item.id == event.product.id)) {
        currentItems.add(event.product);
        await StorageService.saveWishlist(currentItems);
        emit(WishlistLoaded(currentItems));
      }
    }
  }

  Future<void> _onRemoveFromWishlist(
    RemoveFromWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    if (state is WishlistLoaded) {
      final currentItems = List<ProductModel>.from((state as WishlistLoaded).items);
      currentItems.removeWhere((item) => item.id == event.productId);
      
      await StorageService.saveWishlist(currentItems);
      emit(WishlistLoaded(currentItems));
    }
  }

  Future<void> _onToggleWishlist(
    ToggleWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    if (state is WishlistLoaded) {
      final currentState = state as WishlistLoaded;
      
      if (currentState.isInWishlist(event.product.id)) {
        add(RemoveFromWishlistEvent(event.product.id));
      } else {
        add(AddToWishListEvent(event.product));
      }
    }
  }
}