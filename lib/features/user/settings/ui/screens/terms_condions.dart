// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithBackButton(context, isRTL(context),title:AText.termsConditions.tr(context),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             myText(
              "Terms and Conditions".tr(context),
              fontSize: 22, fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
             myText(
              "1. Acceptance of Terms".tr(context),
             fontSize: 18, fontWeight: FontWeight.bold
            ),
            const SizedBox(height: 8),
             myText(
              "acceptance_of_terms_desc".tr(context),
              fontSize: 16
            ),
            const SizedBox(height: 16),
             myText(
              "description_of_service".tr(context),
              fontSize: 18, fontWeight: FontWeight.bold
            ),
            const SizedBox(height: 8),
             myText(
              "description_of_service_desc".tr(context),
             fontSize: 16
            ),
            const SizedBox(height: 16),
             myText(
              "use_of_coupons".tr(context),
              fontSize: 18, fontWeight: FontWeight.bold
            ),
            const SizedBox(height: 8),
          myText(
              "use_of_coupons_desc".tr(context),
              fontSize: 16
            ),
            const SizedBox(height: 16),
             myText(
              "user_responsibility".tr(context),
              fontSize: 18, fontWeight: FontWeight.bold
            ),
            const SizedBox(height: 8),
             myText(
              "user_responsibility_desc".tr(context),
              fontSize: 16
            ),
            const SizedBox(height: 16),
             myText(
              "third_party_links".tr(context),
             fontSize: 18, fontWeight: FontWeight.bold
            ),
            const SizedBox(height: 8),
             myText(
             "third_party_links_desc".tr(context),
         fontSize: 16
            ),
            const SizedBox(height: 16),
             myText(
              "limitation_of_liability".tr(context),
             fontSize: 18, fontWeight: FontWeight.bold
            ),
            const SizedBox(height: 8),
             myText(
             "limitation_of_liability_desc".tr(context),
              fontSize: 16,
            ),
            const SizedBox(height: 16),
             myText(
             "changes_to_service".tr(context),
            fontSize: 18, fontWeight: FontWeight.bold
            ),
            const SizedBox(height: 8),
             myText(
              "changes_to_service_desc".tr(context),
              fontSize: 16
            ),
            const SizedBox(height: 16),
             myText(
              "termination".tr(context),
           fontSize: 18, fontWeight: FontWeight.bold
            ),
            const SizedBox(height: 8),
             myText(
              "termination_desc".tr(context),
           fontSize: 16
            ),
            const SizedBox(height: 16),
             myText(
              "intellectual_property".tr(context),
              fontSize: 18, fontWeight: FontWeight.bold
            ),
            const SizedBox(height: 8),
             myText(
              "intellectual_property_desc".tr(context),
           fontSize: 16
            ),
             SizedBox(height: 16),
              myText(
               "governing_law".tr(context),
            fontSize: 18, fontWeight: FontWeight.bold
            ),
              SizedBox(height: 8),
              myText(
              "governing_law_desc".tr(context),
              fontSize: 16
            ),
              SizedBox(height: 16),
              myText(
              "contact_us".tr(context),
            fontSize: 18, fontWeight: FontWeight.bold
            ),
              SizedBox(height: 8),
              myText(
              "contact_us_desc".tr(context),
           fontSize: 16
            ),
              SizedBox(height: 30), // Extra space at the bottom
          ],
        ),
      ),
    );
  }
}
