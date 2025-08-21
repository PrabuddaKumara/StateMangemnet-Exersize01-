import 'dart:developer';

import 'package:demo/model/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  //cart item state

  Map<String, CartItem> _item = {};

  //getter

  Map<String, CartItem> get items {
    return {..._item};
  }

  //add item

  void addItem(String productId, double price, String title) {
    if (_item.containsKey(productId)) {
      _item.update(
        productId,
        (existingcartItem) => CartItem(
          id: existingcartItem.id,
          title: existingcartItem.title,
          price: existingcartItem.price,
          quantity: existingcartItem.quantity + 1,
        ),
      );
      print("add exsistent data");
    } else {
      _item.putIfAbsent(
        productId,
        () => CartItem(id: productId, title: title, price: price, quantity: 1),
      );
      print("add new cart adata");
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _item.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_item.containsKey(productId)) {
      return;
    }
    if (_item[productId]!.quantity > 1) {
      _item.update(
        productId,
        (existingcartItem) => CartItem(
          id: existingcartItem.id,
          title: existingcartItem.title,
          price: existingcartItem.price,
          quantity: existingcartItem.quantity - 1,
        ),
      );
    } else {
      _item.remove(productId);
    }
    notifyListeners();
  }

  //clear

  void clearAll() {
    _item = {};
    notifyListeners();
  }

  //calculate total
  double get totalAmount {
    var total = 0.0;
    _item.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // final List<Map<String, dynamic>> _items = [];

  // List<Map<String, dynamic>> get items {
  //   return [..._items];
  // }

  // int get totalItems {
  //   return _items.length;
  // }

  // double get totalPrice {
  //   var total = 0.0;
  //   for (var item in _items) {
  //     total += item['price'] * item['quantity'];
  //   }
  //   return total;
  // }

  // void addItem(String productId, String title, double price) {
  //   final existingIndex = _items.indexWhere((item) => item['id'] == productId);
  //   if (existingIndex >= 0) {
  //     _items[existingIndex]['quantity'] += 1;
  //   } else {
  //     _items.add({
  //       'id': productId,
  //       'title': title,
  //       'price': price,
  //       'quantity': 1,
  //     });
  //   }
  //   notifyListeners();
  // }

  // void removeItem(String productId) {
  //   _items.removeWhere((item) => item['id'] == productId);
  //   notifyListeners();
  // }

  // void clearCart() {
  //   _items.clear();
  //   notifyListeners();
  // }
}
