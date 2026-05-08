import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/products_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/manufacturing_screen.dart';
import 'screens/wholesale_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/admin_dashboard_screen.dart';
import 'models/models.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const BenefitsIndustriesApp(),
    ),
  );
}

class BenefitsIndustriesApp extends StatelessWidget {
  const BenefitsIndustriesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Benefits Industries',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const HomeScreen(),
            );
          case '/about':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const AboutScreen(),
            );
          case '/products':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const ProductsScreen(),
            );
          case '/product-detail':
            final product = settings.arguments as Product?;
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => ProductDetailScreen(
                product: product ?? mockProducts.first,
              ),
            );
          case '/manufacturing':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const ManufacturingScreen(),
            );
          case '/wholesale':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const WholesaleScreen(),
            );
          case '/cart':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const CartScreen(),
            );
          case '/contact':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const ContactScreen(),
            );
          case '/admin':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const AdminDashboardScreen(),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            );
        }
      },
    );
  }
}