import 'package:alkor_ecommerce_mt/blocs/cart_bloc/cart_bloc.dart';
import 'package:alkor_ecommerce_mt/blocs/cart_bloc/cart_event.dart';
import 'package:alkor_ecommerce_mt/models/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartItem.product.id.toString()),
      direction: .endToStart,
      background: Container(
        margin: const .only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: .circular(16),
        ),
        alignment: .centerRight,
        padding: const .only(right: 24),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 32,
        ),
      ),
      onDismissed: (direction) {
        context.read<CartBloc>().add(
              RemoveFromCartEvent(cartItem.product.id),
            );
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Item removed from cart'),
            duration: const Duration(seconds: 2),
            behavior: .floating,
          ),
        );
      },
      child: Card(
        margin: const .only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(16),
        ),
        child: Padding(
          padding: const .all(12),
          child: Row(
            children: [
              _buildProductImage(),
              const SizedBox(width: 16),
              Expanded(
                child: _buildProductInfo(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(12),
      ),
      child: ClipRRect(
        borderRadius: .circular(12),
        child: CachedNetworkImage(
          imageUrl: cartItem.product.image,
          fit: BoxFit.contain,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          cartItem.product.title,
          maxLines: 2,
          overflow: .ellipsis,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: .w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '₹${cartItem.product.price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: .bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            _buildQuantityControls(context),
            Text(
              '₹${cartItem.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: .bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityControls(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: .circular(8),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 18),
            onPressed: () {
              if (cartItem.quantity > 1) {
                context.read<CartBloc>().add(
                      DecreaseQuantityEvent(cartItem.product.id),
                    );
              }
            },
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            padding: .zero,
          ),
          Container(
            padding: const .symmetric(horizontal: 12),
            child: Text(
              cartItem.quantity.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: .bold,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 18),
            onPressed: () {
              context.read<CartBloc>().add(
                    IncreaseQuantityEvent(cartItem.product.id),
                  );
            },
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            padding: .zero,
          ),
        ],
      ),
    );
  }
}