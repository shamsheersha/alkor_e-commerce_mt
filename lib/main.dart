import 'package:alkor_ecommerce_mt/blocs/cart_bloc/cart_bloc.dart';
import 'package:alkor_ecommerce_mt/blocs/cart_bloc/cart_event.dart';
import 'package:alkor_ecommerce_mt/blocs/product_bloc/product_bloc.dart';
import 'package:alkor_ecommerce_mt/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:alkor_ecommerce_mt/blocs/wishlist_bloc/wishlist_event.dart';
import 'package:alkor_ecommerce_mt/screens/cart_screen.dart';
import 'package:alkor_ecommerce_mt/screens/home_screen.dart';
import 'package:alkor_ecommerce_mt/screens/splash_screen.dart';
import 'package:alkor_ecommerce_mt/screens/wishlist_screen.dart';
import 'package:alkor_ecommerce_mt/services/api_services.dart';
import 'package:alkor_ecommerce_mt/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc(ApiServices())),
        BlocProvider(
          create: (context) => WishlistBloc()..add(LoadWishListEvent()),
        ),
        BlocProvider(create: (context) => CartBloc()..add(LoadCartEvent())),
      ],
      child: MaterialApp(
        title: 'Alkor E-Commerce',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            primary: Colors.pink,
            secondary: Colors.pinkAccent,
            surface: Colors.grey[50]!,
          ),

          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            foregroundColor: Colors.white,
            backgroundColor: Colors.pink,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: .bold,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),

          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 2,
            surfaceTintColor: Colors.white,
            
          ),

          
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: .dark,
          scaffoldBackgroundColor: Colors.grey.shade900,

          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            brightness: .dark,
            primary: Colors.pinkAccent,
            secondary: Colors.pink,
            surface: Colors.white,
            background: Colors.grey.shade900,
          ),

          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade900,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),

          cardTheme: CardThemeData(
            color: Colors.grey.shade800,
            elevation: 4,
            shadowColor: Colors.black54,
            shape: RoundedRectangleBorder(borderRadius: .circular(15)),
          ),
        ),
        themeMode: .system,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          '/home': (context) => HomeScreen(),
          '/wishlist': (context) => WishlistScreen(),
          '/cart': (context) => CartScreen(),
        },
      ),
    );
  }
}
