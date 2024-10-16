// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:acwadcom/models/category_model.dart';

class Coupon {
  final String title;
  final String code;
  final String couponId;
  final String discountRate;
  final String storeLink;
  final CategoryModel? category;
  final Timestamp endData;
  final int numberOfUse;
  final String additionalTerms;
  final String? storeLogoURL;
  final String? mobileNumberOwner ; 
  final String? emailNumberOwner ; 
  final String? userIDAdded ; 
  final bool isFeatured ;
  final bool isMostUsed;
  final Timestamp uploadDate;

  Coupon(
      {

      this.isFeatured = false,
      this.isMostUsed = false,
      required this.code,
      required this.title, 
      required this.couponId,
      required this.discountRate,
      required this.storeLink,
      required this.category,
      required this.endData,
      required this.numberOfUse,
      required this.uploadDate, 
      required this.additionalTerms, this. storeLogoURL,this.mobileNumberOwner = "", this.emailNumberOwner ="" ,this.userIDAdded ="", 
      });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title':title,
      'code':code,
      'couponId': couponId,
      'DiscountRate': discountRate,
      'StoreLink': storeLink,
      'Category': category?.toJson(),
      'EndData': endData,
      'NumberOfUse': numberOfUse,
      'AdditionalTerms': additionalTerms,
      'storeLogoURL':storeLogoURL,
      'mobileNumberOwner':mobileNumberOwner,
      'emailNumberOwner':emailNumberOwner,
      'userIDAdded':userIDAdded,
      'isFeatured':isFeatured,
      'isMostUsed':isMostUsed,
      'uploadDate':Timestamp.now(),
    };
  }

    factory Coupon.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return Coupon.empty();
    return Coupon(code: data["code"],
     title: data["title"], 
     couponId: data["couponId"],
      discountRate: data["DiscountRate"], 
      storeLink: data["StoreLink"], 
      category: CategoryModel.fromJson(data["Category"]),
       endData: data["EndData"], 
       numberOfUse: data["NumberOfUse"],
        additionalTerms: data["AdditionalTerms"],
        storeLogoURL: data["storeLogoURL"],
        mobileNumberOwner: data["mobileNumberOwner"],
        emailNumberOwner:data["emailNumberOwner"],
        userIDAdded: data["userIDAdded"],
        isFeatured: data["isFeatured"],
        isMostUsed:data["isMostUsed"],
         uploadDate: data["uploadDate"]
        );
  }

  factory Coupon.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return Coupon(
        code: data["code"],
        title: data["title"],
        storeLogoURL :data["storeLogoURL"],
          couponId: document.id,
          discountRate: data["DiscountRate"],
          storeLink: data["StoreLink"],
          category: CategoryModel.fromJson(data["Category"]),
          endData: data["EndData"] is Timestamp 
        ? data["EndData"] 
        : Timestamp.now(), // Handling possible non-Timestamp
          numberOfUse: data["NumberOfUse"],
          additionalTerms: data["AdditionalTerms"],
          mobileNumberOwner: data["mobileNumberOwner"],
          emailNumberOwner: data["emailNumberOwner"],
          userIDAdded: data["userIDAdded"],
          isFeatured: data['isFeatured'] ?? false,
          isMostUsed: data['isMostUsed'] ?? false,
           uploadDate: data["uploadDate"] 
          );
    } else {}
    return Coupon.empty();

    // return Coupon(
    //   document['couponId'] as String,
    //   document['discountRate'] as String,
    //   document['storeLink'] as String,
    //   CategoryModel.fromMap(map['category'] as Map<String,dynamic>),
    //   Timestamp.fromMap(map['endData'] as Map<String,dynamic>),
    //   document['numberOfUse'] as int,
    //   document['additionalTerms'] as String,
    // );
  }

  static Coupon empty() => Coupon(
      couponId: "",
      isFeatured: false,
      isMostUsed: false,
      code: "",
      discountRate: "",
      storeLink: "",
      category: CategoryModel.empty(),
      endData: Timestamp.now(),
      numberOfUse: 0,
      additionalTerms: "", 
      title: '',
      userIDAdded: "",
      mobileNumberOwner: "",
      emailNumberOwner: "",
       uploadDate: Timestamp.now());
}
