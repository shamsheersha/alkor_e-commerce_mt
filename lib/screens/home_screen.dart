import 'package:alkor_ecommerce_mt/blocs/cart_bloc/cart_bloc.dart';
import 'package:alkor_ecommerce_mt/blocs/cart_bloc/cart_state.dart';
import 'package:alkor_ecommerce_mt/blocs/product_bloc/product_bloc.dart';
import 'package:alkor_ecommerce_mt/blocs/product_bloc/product_event.dart';
import 'package:alkor_ecommerce_mt/blocs/product_bloc/product_state.dart';
import 'package:alkor_ecommerce_mt/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:alkor_ecommerce_mt/blocs/wishlist_bloc/wishlist_state.dart';
import 'package:alkor_ecommerce_mt/screens/product_detail_screen.dart';
import 'package:alkor_ecommerce_mt/widgets/product_cart.dart';
import 'package:alkor_ecommerce_mt/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
        ),
        actions: [
          BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              final count = state is WishlistLoaded ? state.items.length : 0;
              return badges.Badge(
                showBadge: count > 0,
                badgeContent: Text(
                  count.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                position: .topEnd(top: 4, end: 4),
                child: IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () => Navigator.pushNamed(context, '/wishlist'),
                ),
              );
            },
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final count = state is CartLoaded ? state.totalItems : 0;
              return badges.Badge(
                showBadge: count > 0,
                badgeContent: Text(
                  count.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                position: .topEnd(top: 4, end: 4),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () => Navigator.pushNamed(context, '/cart'),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryFilter(),
          Expanded(child: _buildProductList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const .all(16),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          context.read<ProductBloc>().add(SearchProductEvent(value));
        },
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<ProductBloc>().add(SearchProductEvent(''));
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: .circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = [
      'All',
      'electronics',
      'jewelery',
      "men's clothing",
      "women's clothing",
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: .horizontal,
        padding: const .symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = (_selectedCategory == null && category == 'All') ||
              _selectedCategory == category;

          return Padding(
            padding: const .only(right: 8),
            child: FilterChip(
              label: Text(
                category == 'All' ? category : category.toUpperCase(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category == 'All' ? null : category;
                });
                context.read<ProductBloc>().add(
                      FilterbyCategoryEvent(_selectedCategory),
                    );
              },
              selectedColor: Theme.of(context).colorScheme.primary,
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductList() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const ShimmerLoading();
        }

        if (state is ProductError) {
          return Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  'Oops! Something went wrong',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Please try again later',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<ProductBloc>().add(FetchProductsEvent());
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is ProductLoaded) {
          if (state.filteredProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No products found',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try adjusting your search or filters',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const .all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.61,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: state.filteredProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: state.filteredProducts[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(
                        product: state.filteredProducts[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}