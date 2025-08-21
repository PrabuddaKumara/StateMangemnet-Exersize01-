import 'package:demo/data/product_data.dart';
import 'package:demo/model/product_model.dart';
import 'package:demo/providers/card_provider.dart';
import 'package:demo/providers/favorite_provider.dart';
import 'package:demo/screens/cart_page.dart';
import 'package:demo/screens/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Shop ',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
            },
            backgroundColor: Colors.deepOrange,
            heroTag: "favorite_button",
            child: Icon(Icons.favorite, size: 30, color: Colors.white),
          ),

          SizedBox(width: 20),

          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            backgroundColor: Colors.deepOrange,
            heroTag: "cart_button",
            child: Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,

        itemBuilder: (context, index) {
          final Product product = products[index];

          return Card(
            child: Consumer2<CartProvider, FavoriteProvider>(
              builder:
                  (
                    BuildContext context,
                    CartProvider cartprovider,
                    FavoriteProvider favoriteprovider,
                    Widget? child,
                  ) {
                    return ListTile(
                      title: Row(
                        children: [
                          Text(product.title),
                          SizedBox(width: 10),

                          //todo price
                          Text(
                            cartprovider.items.containsKey(product.id)
                                ? cartprovider.items[product.id]!.quantity
                                      .toString()
                                : "0",
                          ),
                          Spacer(),

                          //
                          IconButton(
                            onPressed: () {
                              favoriteprovider.toggleFavorite(product.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    favoriteprovider.isFavorite(product.id)
                                        ? "Add to favorite"
                                        : "Removed the favorite",
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              favoriteprovider.isFavorite(product.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: favoriteprovider.isFavorite(product.id)
                                  ? Colors.pinkAccent
                                  : Colors.grey,
                            ),
                          ),

                          //
                          IconButton(
                            onPressed: () {
                              cartprovider.addItem(
                                product.id,
                                product.price,
                                product.title,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Add the cart............."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              // cartprovider.addItem()
                            },
                            icon: Icon(
                              Icons.shopping_cart,
                              color: cartprovider.items.containsKey(product.id)
                                  ? Colors.deepOrange
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      subtitle: Text(product.price.toString()),
                    );
                  },
            ),
          );
        },
      ),
    );
  }
}
