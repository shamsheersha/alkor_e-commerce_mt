import 'package:alkor_ecommerce_mt/screens/home_screen.dart';
import 'package:alkor_ecommerce_mt/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          shadowColor: Colors.pinkAccent.withOpacity(0.2),
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // Floating Action Button
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
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
          surface: Colors.grey.shade800,
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
      routes: {'/home': (context) => HomeScreen()},
    );
  }
}
