import 'package:acwadcom/app_localizations.dart';
import 'package:acwadcom/helpers/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acwadcom/common/widgets/rounded_button_widget.dart';
import 'package:acwadcom/cubit/locale_cubit.dart';
import 'package:acwadcom/helpers/constants/colors.dart';
import 'package:lottie/lottie.dart';

class LanguageSelectionPage extends StatefulWidget {
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  // List of available languages with their names and flags
  final List<Map<String, String>> languages = [
    {"name": AText.en, "flag": "🇺🇸"},
    {"name": AText.ar, "flag": "🇸🇦"},
  ];

  String selectedLanguage = ""; // Default selected language

    // Method to show the popup with "Done" icon
  void showDonePopup() {
    showDialog(
      context: context,
      // barrierColor: ManagerColors.kCustomColor,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:  ManagerColors.kCustomColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: LottieBuilder.asset("assets/lottie/Animation - 1727095084054.json")
        );
      },
    );

    // Automatically close the dialog after 1.5 seconds
    Future.delayed(Duration(seconds: 2), () {
       Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    super.initState();
    // Set the initial selected language based on the state
    Locale currentLocale = context.read<LocaleCubit>().state.locale;
    selectedLanguage = currentLocale.languageCode == "ar" ? AText.ar : AText.en;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AText.changeLanguage.tr(context),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AText.selectlanguage.tr(context),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ManagerColors.kCustomColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(
                          languages[index]['flag']!,
                          style: const TextStyle(fontSize: 30),
                        ),
                        title: Text(
                          languages[index]['name']!.tr(context),
                          style: const TextStyle(fontSize: 18),
                        ),
                        trailing: selectedLanguage == languages[index]['name']!
                            ? Icon(Icons.check_circle, color: Colors.teal)
                            : null,
                        onTap: () {
                          setState(() {
                            selectedLanguage = languages[index]['name']!;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
            RoundedButtonWgt(
              title: AText.saveChanges.tr(context),
              onPressed: () {
                context.read<LocaleCubit>().changeLanguage(selectedLanguage);
                showDonePopup();
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: RichText(
                //       text: TextSpan(
                //         children: [
                //           TextSpan(text: AText.langTo.tr(context)),
                //           // TextSpan(text:selectedLanguage )
                //         ]
                //       ),
                //     ),
                //   ),
                // );
                // Implement your language change save logic here if needed
              },
            ),
          ],
        ),
      ),
    );
  }
}