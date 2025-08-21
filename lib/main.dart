import 'package:demo/providers/card_provider.dart';
import 'package:demo/providers/favorite_provider.dart';
import 'package:demo/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // ChangeNotifierProvider(create: (context) => CartProvider(), child: MyApp()),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ProductPage());
  }
}
