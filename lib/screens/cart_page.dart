import 'package:demo/providers/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart  page",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder:
            (BuildContext context, CartProvider cartprovider, Widget? child) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartprovider.items.length,

                      itemBuilder: (context, index) {
                        final CartItem cartitem = cartprovider.items.values
                            .toList()[index];
                        return Container(
                          color: Colors.deepOrange.withOpacity(0.4),
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(cartitem.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(cartitem.id),
                                Text("${cartitem.price}*${cartitem.quantity}"),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                IconButton(
                                  onPressed: () {
                                    //  cartprovider.removeItem(cartitem.id);
                                    cartprovider.removeSingleItem(cartitem.id);
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cartprovider.removeItem(cartitem.id);
                                  },
                                  icon: Icon(Icons.remove_shopping_cart),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Total  : ${cartprovider.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cartprovider.clearAll();
                    },
                    child: Text("Clear Button"),
                  ),
                ],
              );
            },
      ),
    );
  }
}
