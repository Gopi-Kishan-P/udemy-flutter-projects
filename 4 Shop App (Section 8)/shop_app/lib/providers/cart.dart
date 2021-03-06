import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmt {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity + 1,
            title: existingCartItem.title),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          price: price,
          quantity: 1,
          title: title,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String prodId) {
    _items.remove(prodId);
    notifyListeners();
  }

  void removeSingleItem(String prodId) {
    if (_items.containsKey(prodId)) {
      if (_items[prodId].quantity > 1) {
        _items.update(
          prodId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1,
              title: existingCartItem.title),
        );
      }else{
        _items.remove(prodId);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
