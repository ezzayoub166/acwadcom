import 'dart:io';

import 'package:acwadcom/features/admin/ui/screens/list_offers_screen.dart';
import 'package:acwadcom/models/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_app_bar_for_admin.dart';
import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AddOfferScreen extends StatefulWidget {
  const AddOfferScreen({super.key});

  @override
  State<AddOfferScreen> createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  final _db = FirebaseFirestore.instance;
  final _imagePicker = ImagePicker();
  XFile? _selectedImage;
  bool _isUploadingImage = false;
  bool _isAddedURL = false;
  TextEditingController urlController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> selectImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No image selected.")),
      );
    }
  }

  Future<void> uploadOfferPicture() async {
    var offerID = const Uuid().v1();

    if (_selectedImage == null) {
      TLoader.showWarningSnackBar(context,
          title: "Please select an image first.");
      return;
    }

    if (!formKey.currentState!.validate()) {
      TLoader.showWarningSnackBar(context,
          title: "Please add linke of offer you need go when click it.");

      return;
    }

    setState(() {
      _isUploadingImage = true;
      _isAddedURL = true;
    });

    try {
      showDialog(
        context: context,
        builder: (context) => Center(child: BuildCustomLoader()),
      );

      final imageUrl = await getIt<UserRepository>().uploadImage(
        'Users/images/Offers/',
        _selectedImage!, // Pass XFile directly
      );

      await addOfferImage(OfferModel(
          id: offerID, imageUrl: imageUrl, offerUrl: urlController.text));

      Navigator.of(context).pop(); // Close loader dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Offer image uploaded successfully.")),
      );

      TLoader.showSuccessSnackBar(context,
          title: "Success", message: "Offer image uploaded successfully.");

      setState(() {
        _isUploadingImage = false;
        _isAddedURL = false;
        _selectedImage = null; // Reset image after upload
      });
    } catch (error) {
      Navigator.of(context).pop(); // Close loader dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image: $error")),
      );
      setState(() {
        _isUploadingImage = false;
      });
    }
  }

  Future<void> addOfferImage(OfferModel offer) async{
    await _db.collection("Offers").doc(offer.id).set(offer.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarForAdmin(context, "Add Offers Page"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            GestureDetector(
              onTap: selectImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: ManagerColors.kCustomColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _selectedImage != null
                    ? Image.file(File(_selectedImage!.path), fit: BoxFit.cover)
                    : const Center(
                        child: Text(
                          "Add the offer image",
                          style: TextStyle(
                            fontSize: 16,
                            color: ManagerColors.yellowColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),
            buildSpacerH(20.0),
            Form(
              key: formKey,
              child: RoundedInputField(
                  controller: urlController,
                  // key: formKey,
                  hintText: "linke of Offer",
                  validator: (value) =>
                      ManagerValidator.validateURL(value, context)),
            ),
            buildSpacerH(10.0),
            ElevatedButton(
              onPressed:
                  _isUploadingImage && _isAddedURL ? null : uploadOfferPicture,
              child: const Text("Upload Offer Image"),
            ),
            buildSpacerH(10.0),
            ElevatedButton(
              onPressed: () {
                navigateTo(context, ListOffersScreen());
              },
              child: const Text("Show All Offers."),
            ),
            buildSpacerH(10.0),
          ],
        ),
      ),
    );
  }
}
