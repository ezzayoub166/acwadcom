import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? categoryId;
  Map<String, dynamic> title; // To support multi-language titles
  String image;
  bool isSelected;

  CategoryModel({
    this.categoryId,
    required this.title,
    required this.image,
    this.isSelected = false,
  });

  /// Convert model to JSON for storing in Firestore
  Map<String, dynamic> toJson() {
    return {
      "CategoryId": categoryId,
      "Title": title, // Map of titles (e.g., {'en': 'All', 'ar': 'الكل'})
      "Image": image,
    };
  }

  /// Convert Firestore JSON data to CategoryModel
  factory CategoryModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return CategoryModel.empty();

    return CategoryModel(
      categoryId: data['CategoryId'] ?? '',
      title: Map<String, dynamic>.from(data['Title'] ?? {}), // Map the title field
      image: data['Image'] ?? '',
    );
  }

  /// Convert Firestore document snapshot to CategoryModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        categoryId: document.id,
        title: Map<String, dynamic>.from(data['Title'] ?? {}),
        image: data['Image'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }

  /// Helper: Empty CategoryModel
  static CategoryModel empty() =>
      CategoryModel(categoryId: '', title: {}, image: '');

  /// Get localized title based on current locale
  String getLocalizedTitle(String locale) {
    return title[locale] ?? title['en'] ?? ''; // Fallback to English if locale is missing
  }
}
