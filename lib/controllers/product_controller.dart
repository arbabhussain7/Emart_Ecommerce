import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/firebase_const.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;
  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategoeies) {
      subcat.add(e);
    }
  }

  increaseQuality(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuality() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, sellername, color, qty, tprice}) async {
    await firestore.collection(cartCollection).doc().set({
      "title": title,
      "img": img,
      "sellername": sellername,
      "color": color,
      "qty": qty,
      "tprice": tprice,
      "add_by": currentUser!.uid
    });
  }

  resetValue() {
    totalPrice.value = 0;
    quantity.value = 0;
  }

  addToWishlist(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      "p_wishlist": FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
  }

  removeFromWishlist(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      "p_wishlist": FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
  }

  checkIfFav(data) async {
    if (data["p_wishlist"].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
    ;
  }
}
