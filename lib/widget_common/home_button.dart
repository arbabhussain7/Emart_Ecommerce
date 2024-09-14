import 'package:emart_app/consts/consts.dart';

Widget HomeButton({onPress, String? title, icon, width, height}) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 26,
        ),
        10.heightBox,
        title!.text.fontFamily(semibold).color(darkFontGrey).make()
      ],
    ),
  ).box.rounded.white.size(width, height).make();
}
