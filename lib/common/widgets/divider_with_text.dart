import 'package:acwadcom/app_localizations.dart';
import 'package:acwadcom/helpers/constants/strings.dart';
import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {

  const DividerWithText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // Left Divider
        const Expanded(
          child: Divider(
            thickness: 1.5, // Adjust thickness
            color: Colors.white, // Adjust color
            indent: 10.0, // Adjust starting space
            endIndent: 10.0, // Adjust ending space
          ),
        ),
        
        // Center Text
        Text(
          AText.or.tr(context),
          style: const TextStyle(
            fontSize: 18, // Adjust font size
            color: Colors.white, // Adjust text color
          ),
        ),
        
        // Right Divider
        const Expanded(
          child: Divider(
            thickness: 1.5, // Adjust thickness
            color: Colors.white, // Adjust color
            indent: 10.0, // Adjust starting space
            endIndent: 10.0, // Adjust ending space
          ),
        ),
      ],
    );
  }
}