import '../../acwadcom_packges.dart';

Widget buildRemaingTimeForDiscountCode(BuildContext context, String remainingTime ,[ Color text = ManagerColors.yellowColor, Color value = ManagerColors.kCustomColor]) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      myText(AText.remaingTimeForDiscountCode.tr(context),
          fontSize: 10, color: text),
      Text(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 12, color: value
        ),
        remainingTime,
      ),

    ],
  );
}