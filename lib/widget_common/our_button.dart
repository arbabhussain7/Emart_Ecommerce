import 'package:emart_app/consts/consts.dart';

Widget OurButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // primary: redColor,
        backgroundColor: color,
        padding: EdgeInsets.all(12),
      ),
      onPressed: onPress,
      child: title?.text.color(textColor).fontFamily(bold).make());
}
