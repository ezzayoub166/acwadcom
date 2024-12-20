
import 'dart:io';
import 'package:acwadcom/features/ownerStore/features/authitcation/ui/widgets/build_requird_image_selected.dart';
import 'package:image/image.dart' as img;

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:path_provider/path_provider.dart';

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
   void showRequireImageSelectedDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RequiredImageSelectedWgt();
      },
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

  String getMimeType(File file) {
  final extension = file.path.split('.').last.toLowerCase();
  switch (extension) {
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'png':
      return 'image/png';
    case 'gif':
      return 'image/gif';
    default:
      return 'application/octet-stream'; // Fallback for unknown types
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


//   void copyToClipboard(String discountCode, BuildContext context) {
//   Clipboard.setData(ClipboardData(text: discountCode)); // Copy to clipboard
//   TLoader.showSuccessSnackBar(context, title: "Code copied".tr(context));
// }

  // Function to copy the discount code
  void copyCouponToClipboard(Coupon coupon, BuildContext context) {
    Clipboard.setData(ClipboardData(text: coupon.code)); // Copy to clipboard
    if(!copiedCoupons.contains(coupon.code)){
      getIt<CouponRepository>().updateStringFiled(json: {"NumberOfUse":coupon.numberOfUse+1}, couponID: coupon.couponId);
          TLoader.showSuccessSnackBar(context, title: "Code copied".tr(context));
    }else{
    TLoader.showSuccessSnackBar(context, title: "Code copied".tr(context));

    }
  }

void copyTextToClipboard(String text, BuildContext context) {
  Clipboard.setData(ClipboardData(text: text)); // Copy to clipboard
    TLoader.showSuccessSnackBar(context, title: "${text} copied".tr(context));
}

 void launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url); // Ensure the URL is parsed correctly

    if (await canLaunchUrl(uri)) {
      // Open the URL in the browser
      await launchUrl(uri, mode: LaunchMode.externalApplication); 
    } else {
      // If the URL cannot be opened, show an error
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Could not open the link!')),
      // );
      return TLoader.showErrorSnackBar(context, title: 'Could not open the link!');
    }
  }


// extension StringExtension on String? {
//   bool isNullOrEmpty() => this == null || this == "";
// }
Future<File?> convertToJpeg(File file) async {
  try {
    // Load the image
    final imageBytes = file.readAsBytesSync();
    img.Image? image = img.decodeImage(imageBytes);

    // Ensure image is loaded
    if (image != null) {
      // Convert to JPEG
      final jpegBytes = img.encodeJpg(image, quality: 90); // Adjust quality as needed

      // Get directory to save the new file
      final directory = await getApplicationDocumentsDirectory();
      final newPath = '${directory.path}/converted_image.jpg';

      // Save the JPEG file
      final jpegFile = File(newPath);
      await jpegFile.writeAsBytes(jpegBytes);
      return jpegFile;
    } else {
      print("Failed to decode image.");
      return null;
    }
  } catch (e) {
    print("Error during JPEG conversion: $e");
    return null;
  }
}