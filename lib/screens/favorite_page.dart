import 'package:demo/data/product_data.dart';
import 'package:demo/model/product_model.dart';
import 'package:demo/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite page",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<FavoriteProvider>(
        builder:
            (
              BuildContext context,
              FavoriteProvider favoriteProvider,
              Widget? child,
            ) {
              final favItemsIds = favoriteProvider.favorites.entries
                  .where(
                    (entry) => entry.value == true,
                  ) // Filter for true values (favorites)
                  .map((entry) => entry.key) // Extract the key (product ID)
                  .toList();

              if (favItemsIds.isEmpty) {
                return const Center(
                  child: Text("You have no favorite items yet!"),
                );
              }
              return ListView.builder(
                itemCount: favItemsIds.length,
                itemBuilder: (context, index) {
                  final productId = favItemsIds[index];
                  final Product product = ProductData().products.firstWhere(
                    (protected) => protected.id == productId,
                  );
                  return Card(
                    child: ListTile(
                      title: Text(product.title),
                      subtitle: Text("${product.price}"),
                      trailing: IconButton(
                        onPressed: () {
                          favoriteProvider.toggleFavorite(productId);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              );
            },
      ),
    );
  }
}
