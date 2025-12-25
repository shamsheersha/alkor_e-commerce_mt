import 'package:alkor_ecommerce_mt/blocs/cart_bloc/cart_bloc.dart';
import 'package:alkor_ecommerce_mt/blocs/cart_bloc/cart_event.dart';
import 'package:alkor_ecommerce_mt/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:alkor_ecommerce_mt/blocs/wishlist_bloc/wishlist_event.dart';
import 'package:alkor_ecommerce_mt/blocs/wishlist_bloc/wishlist_state.dart';
import 'package:alkor_ecommerce_mt/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    _buildProductImage(),
                    _buildProductInfo(),
                    _buildDescription(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      pinned: true,
      actions: [
        BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            final isInWishlist = state is WishlistLoaded &&
                state.isInWishlist(widget.product.id);

            return IconButton(
              icon: Icon(
                isInWishlist ? Icons.favorite : Icons.favorite_border,
                color: isInWishlist ? Colors.white : null,
              ),
              onPressed: () {
                context
                    .read<WishlistBloc>()
                    .add(ToggleWishlistEvent(widget.product));
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isInWishlist
                          ? 'Removed from wishlist'
                          : 'Added to wishlist',
                    ),
                    duration: const Duration(seconds: 1),
                    behavior: .floating,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    return Hero(
      tag: 'product_${widget.product.id}',
      child: Container(
        height: 400,
        width: .infinity,
        color: Colors.white,
        child: CachedNetworkImage(
          imageUrl: widget.product.image,
          fit: .contain,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            size: 64,
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const .all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Container(
            padding: const .symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: .circular(20),
            ),
            child: Text(
              widget.product.category.toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: .bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.product.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: .bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              RatingBarIndicator(
                rating: widget.product.rating!.rate,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
              ),
              const SizedBox(width: 8),
              Text(
                '${widget.product.rating!.rate} (${widget.product.rating!.count} reviews)',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '₹${widget.product.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 32,
              fontWeight: .bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const .all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: .bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const .all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () {
            context.read<CartBloc>().add(AddToCartEvent(widget.product));
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Added to cart'),
                duration: const Duration(seconds: 2),
                behavior: .floating,
                action: SnackBarAction(
                  label: 'VIEW CART',
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            padding: const .symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: .circular(12),
            ),
          ),
          child: const Row(
            mainAxisAlignment: .center,
            children: [
              Icon(Icons.shopping_cart),
              SizedBox(width: 8),
              Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: .bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}