import 'package:alkor_ecommerce_mt/blocs/cart_bloc/cart_bloc.dart';
import 'package:alkor_ecommerce_mt/blocs/cart_bloc/cart_event.dart';
import 'package:alkor_ecommerce_mt/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:alkor_ecommerce_mt/blocs/wishlist_bloc/wishlist_event.dart';
import 'package:alkor_ecommerce_mt/blocs/wishlist_bloc/wishlist_state.dart';
import 'package:alkor_ecommerce_mt/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            _buildImage(context),
            Expanded(
              child: Padding(
                padding: const .all(12),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: .ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: .w600,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '₹${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: .bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber[700],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              product.rating!.rate.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: .w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    _buildAddToCartButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'product_${product.id}',
          child: Container(
            height: 140,
            width: .infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const .vertical(
                top: .circular(16),
              ),
            ),
            child: ClipRRect(
              borderRadius: const .vertical(
                top: .circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: .contain,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              final isInWishlist =
                  state is WishlistLoaded && state.isInWishlist(product.id);

              return Container(
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: .rectangle,
                  borderRadius: .only(
                    bottomLeft: .circular(11),
                    topRight: .circular(11),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    isInWishlist ? Icons.favorite : Icons.favorite_border,
                    color: isInWishlist ? Colors.red : Colors.grey,
                    size: 20,
                  ),
                  onPressed: () {
                    context.read<WishlistBloc>().add(
                      ToggleWishlistEvent(product),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CartBloc>().add(AddToCartEvent(product));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Added to cart'),
            duration: const Duration(seconds: 1),
            behavior: .floating,
            margin: const .only(bottom: 80, left: 16, right: 16),
          ),
        );
      },
      child: Container(
        width: .infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: .circular(8),
        ),
        child: Padding(
          padding: const .all(8.0),
          child: Row(
            mainAxisAlignment: .center,
            children: [
              Icon(Icons.add_shopping_cart, size: 20, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: .bold,
                  color: Colors.white,
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
