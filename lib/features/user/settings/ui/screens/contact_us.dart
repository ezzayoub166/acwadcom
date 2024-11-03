// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/coupons/ui/screens/add_coupon_screen.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/helpers/constants/build_extenstions.dart';
import 'package:acwadcom/helpers/constants/other_tools.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManagerColors.whiteBtnBackGround,
      appBar: buildAppBarWithBackButton(context, isRTL(context),
          title: AText.reportProblem),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
        child: ListView(
          children: [
            InkWell(
              onTap: () async {
                const url = 'https://wa.me/+966533343609';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("WhatsApp not installed")));
                }
              },
              child: buildListTitleSettings(
                  context: context,
                  icon: "_icWhatsappLogo",
                  title: AText.whatsapp,
                  background: ManagerColors.kCustomColor,
                  textColor: Colors.white,
                  colorArraw: Colors.white),
            ),
            buildSpacerH(10.0),
            InkWell(
              onTap: () async {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'appacwdcom@gmail.com', // Your email address
                  queryParameters: {
                    'subject': 'subject', // Subject of the email
                    'body': 'body', // Body of the email
                  },
                );

                // Launch the email app
                if (await canLaunchUrl(emailUri)) {
                  await launchUrl(emailUri);
                } else {
                  // Handle error when the email app can't be launched
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not open the email app')),
                  );
                }
              },
              child: buildListTitleSettings(
                  context: context,
                  icon: "_icEmailLogo",
                  title: AText.email,
                  background: ManagerColors.greyLighColor,
                  textColor: ManagerColors.kCustomColor,
                  colorArraw: ManagerColors.kCustomColor),
            ),
          ],
        ),
      ),
    );
  }
}

Container buildListTitleSettings(
    {required BuildContext context,
    required String icon,
    required String title,
    required Color background,
    required Color textColor,
    required Color colorArraw}) {
  return Container(
    decoration: buildDecorationProfile(background),
    child: ListTile(
      title: myText(title.tr(context), fontSize: 18, color: textColor),
      leading: svgImage(icon),
      trailing: Icon(Icons.arrow_forward_ios, color: colorArraw),
      // onTap: () {
      //   // Navigate to account settings
      //   navigateTo(context, CreateCodeScreen());
      // },
    ),
  );
}
