
import 'package:acwadcom/acwadcom_packges.dart';

import 'package:url_launcher/url_launcher.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateNamedTo(BuildContext context, String routeName, [Object? arguments]) {
  Navigator.pushNamed(
    context,
    routeName,
    arguments: arguments,
  );
}
void pop(context) => Navigator.pop(context);

void navigateAndFinishNamed(BuildContext context, String routeName, [Object? arguments]) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    routeName,
    (Route<dynamic> route) => false, // This removes all previous routes from the stack
    arguments: arguments,
  );
}

Future<void> _launchUrl(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
void _modalBottomSheetMenu(context) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return new Container(
          height: 350.0,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: new Center(
                child: new Text("This is a modal sheet"),
              )),
        );
      });
}

enum FontWeightEnum {
  Thin,
  ExtraLight,
  Light,
  Regular,
  Medium,
  SemiBold,
  Bold,
  ExtraBold,
}

extension FontWeightExtension on FontWeightEnum {
  FontWeight get fontWeight {
    switch (this) {
      case FontWeightEnum.Thin:
        return FontWeight.w100;
      case FontWeightEnum.ExtraLight:
        return FontWeight.w200;
      case FontWeightEnum.Light:
        return FontWeight.w300;
      case FontWeightEnum.Regular:
        return FontWeight.w400;
      case FontWeightEnum.Medium:
        return FontWeight.w500;
      case FontWeightEnum.SemiBold:
        return FontWeight.w600;
      case FontWeightEnum.Bold:
        return FontWeight.w700;
      case FontWeightEnum.ExtraBold:
        return FontWeight.w800;
    }
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
String convertTimestampToDateString(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp);
  String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  return formattedDate;
}


// extension StringExtension on String? {
//   bool isNullOrEmpty() => this == null || this == "";
// }