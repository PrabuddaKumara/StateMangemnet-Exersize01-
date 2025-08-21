import 'package:flutter/cupertino.dart';

class FavoriteProvider extends ChangeNotifier {
  //state
  final Map<String, bool> _favorites = {};

  //getter
  Map<String, bool> get favorites => _favorites;

  //toggle favorite

  void toggleFavorite(String productId) {
    if (_favorites.containsKey(productId)) {
      _favorites[productId] = !_favorites[productId]!;
    } else {
      _favorites[productId] = true;
    }
    notifyListeners();
  }

  bool isFavorite(String productId) {
    return _favorites[productId] ?? false;
  }
}
