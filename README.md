#  E-Commerce Flutter App

A modern, feature-rich e-commerce mobile application built with Flutter and BLoC state management.

## Features

### 🛍️ Product List Screen
- Fetch products from FakeStore API
- Display product image, name, price and rating
- Add to Cart functionality with animated feedback
- Add/Remove from Wishlist with heart icon
- Product search with real-time filtering
- Category filter chips (All, Electronics, Jewelry, Men's Clothing, Women's Clothing)
- Shimmer loading effect
- Error handling with retry option
- Empty state handling
- Grid layout with responsive design

### 📱 Product Details Screen
- Beautiful hero animation from product list
- High-quality product image display
- Product title, category badge, and description
- Star rating with review count
- Price display with prominent styling
- Add to Cart button with bottom bar
- Add/Remove from Wishlist functionality
- Smooth entrance animations

### 🛒 Cart Screen
- Display all cart items with images
- Increase/decrease quantity controls
- Remove items with swipe-to-dismiss gesture
- Show subtotal, shipping cost, and total
- Free shipping notification for orders over ₹50
- Progress indicator for free shipping eligibility
- Persistent cart state across app sessions
- Empty cart state with call-to-action
- Checkout dialog

### ❤️ Wishlist Screen
- Display all wishlisted products in grid
- Remove items from wishlist
- Navigate to product details
- Empty wishlist state
- Persistent wishlist state

### 🎨 Additional Features
- Animated splash screen with gradient background
- Badge counters on cart and wishlist icons
- Material 3 design with custom theme
- Smooth page transitions
- Responsive UI with no overflow issues
- Null safety enabled
- Clean architecture with separation of concerns

## Tech Stack

- **Flutter**: Latest stable version
- **State Management**: BLoC (flutter_bloc)
- **API**: FakeStore API
- **Local Storage**: SharedPreferences
- **Image Caching**: cached_network_image
- **Animations**: Built-in Flutter animations
- **UI Components**: 
  - shimmer (loading skeleton)
  - badges (notification badges)
  - flutter_rating_bar (star ratings)

## Project Structure

```
lib/
├── main.dart
├── models/
│   ├── product_model.dart
│   └── cart_item_model.dart
├── services/
│   ├── api_service.dart
│   └── storage_service.dart
├── bloc/
│   ├── product/
│   │   └── product_bloc.dart
│   ├── cart/
│   │   └── cart_bloc.dart
│   └── wishlist/
│       └── wishlist_bloc.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── product_detail_screen.dart
│   ├── cart_screen.dart
│   └── wishlist_screen.dart
└── widgets/
    ├── product_card.dart
    ├── cart_item_widget.dart
    └── shimmer_loading.dart
```


## API Reference

This app uses the [FakeStore API](https://fakestoreapi.com/):
- `GET /products` - Fetch all products


## State Management

The app uses BLoC pattern for state management:

- **ProductBloc**: Manages product list, search, and filtering
- **CartBloc**: Manages cart items, quantities, and persistence
- **WishlistBloc**: Manages wishlist items and persistence

## Key Features Implementation

### Search Functionality
- Real-time search as user types
- Searches in product title and category
- Works in combination with category filters

### Cart Persistence
- Cart state is saved to local storage using SharedPreferences
- Cart persists across app restarts
- Automatic save on every cart operation

### Wishlist Persistence
- Wishlist state is saved to local storage
- Persists across app sessions
- Toggle functionality with visual feedback

### Animations
- Splash screen with scale and fade animations
- Hero animations for product images
- Slide and fade animations on product detail screen
- Swipe-to-dismiss gesture for cart items
- Smooth snackbar notifications

## Screenshots
![alt text](<WhatsApp Image 2025-12-25 at 4.41.59 PM.jpeg>)
![alt text](<WhatsApp Image 2025-12-25 at 4.41.59 PM (1).jpeg>)
![alt text](<WhatsApp Image 2025-12-25 at 4.42.00 PM.jpeg>)
![alt text](<WhatsApp Image 2025-12-25 at 4.42.01 PM (1).jpeg>)
![alt text](<WhatsApp Image 2025-12-25 at 4.41.58 PM (1).jpeg>)
![alt text](<WhatsApp Image 2025-12-25 at 4.42.00 PM (1).jpeg>)
![alt text](<WhatsApp Image 2025-12-25 at 4.41.58 PM (2).jpeg>)
![alt text](<WhatsApp Image 2025-12-25 at 4.42.01 PM.jpeg>)
![alt text](<WhatsApp Image 2025-12-25 at 4.42.00 PM (2).jpeg>)
![alt text](<WhatsApp Image 2025-12-25 at 4.41.58 PM.jpeg>)
## Performance Optimizations

- Image caching with `cached_network_image`
- Efficient list rendering with `ListView.builder` and `GridView.builder`
- Lazy loading of images
- Optimized state updates with BLoC
- Shimmer loading for better perceived performance




