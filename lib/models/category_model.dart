
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
   String? categoryId ;
   String title ; 
   String image ;
     bool isSelected;


  CategoryModel({this.categoryId, required this.title, required this.image , this.isSelected =false}); 

    Map<String, dynamic> toJson() {
    return {
      "CategoryId": categoryId,
      "Title": title,
      "Image": image,
    };
  }

     ///Map json oriented document snapshot form firebase to UserModel
  factory CategoryModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return CategoryModel.empty();
    return CategoryModel(
        categoryId: data['CategoryId'] ?? '',
        title: data['Title'] ?? '',
        image: data['Image'] ?? '',
  );
  }

  ///convert model to json structure so that you can store data in fireBase
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      //Map JSON Record to the Model
      return CategoryModel(
          categoryId: document.id,
          title: data['Title'] ?? '',
          image: data['Image'] ?? '',
        );
    }else{
      return CategoryModel.empty();
    }
  }

   ///Empty Helper Function
  static CategoryModel empty() => CategoryModel(
      categoryId: '', title: '', image: '');

}