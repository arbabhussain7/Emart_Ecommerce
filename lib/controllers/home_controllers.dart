import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class HomeControllers extends GetxController {
  var curentNavIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUsername();
  }

  var username = "";
  getUsername() async {
    var n = await firestore
        .collection(userCollection)
        .where("id", isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    username = n;
  }
}
