// import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/firebase_const.dart';
// import 'package:flutter/foundation.dart';

class FirestoreServices {
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get product according to company ....
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //get Cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where("add_by", isEqualTo: uid)
        .snapshots();
  }

  //delete Documents
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }
//get all chats messages

  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        // .orderBy("create_on", descending: false)
        .snapshots();
  }
}
