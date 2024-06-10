import 'package:foodie/models/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    if (quantity == 0) {
      Get.snackbar("Item count", "You should at least add an item in the cart!");
      return;
    }

    if (_items.containsKey(product.id!)) {
      // Update the quantity of an existing item
      int totalQuantity = _items[product.id!]!.quantity! + quantity;
      if (totalQuantity > 0) {
        _items.update(product.id!, (value) {
          return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: totalQuantity,
            isExist: true,
            product: product,
          );
        });
        Get.snackbar("Item count", "Item added to cart!");
      } else if (totalQuantity <= 0) {
        _items.remove(product.id!);
        Get.snackbar("Item count", "Item removed from cart!");
      }
    } else {
      // Add a new item to the cart
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          Get.snackbar("Item count", "Item added to cart!");
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            product: product,
          );
        });
      } else {
        Get.snackbar("Item count", "You should at least add an item in the cart!");
      }
    }

    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    return _items.containsKey(product.id);
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) => e.value).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistory();
  }
}
