import 'package:emart_app/consts/consts.dart';

Widget loadingIndicatior() {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
