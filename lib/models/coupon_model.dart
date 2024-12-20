// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:acwadcom/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:acwadcom/models/category_model.dart';

class Coupon {
  final String title;
  final String code;
  final String couponId;
  final String discountRate;
  final String storeLink;
  CategoryModel? category;
  final Timestamp endData;
  final int numberOfUse;
  final String additionalTerms;
  final String? storeLogoURL;
  final Timestamp uploadDate;
  final UserModel ownerCoupon;
  final String ownerCouponId ;
  final String categoryID;

  Coupon(
      {
       this.categoryID = "",
      required this.code,
      required this.ownerCouponId,
      required this.title, 
      required this.couponId,
      required this.discountRate,
      required this.storeLink,
      required this.category,
      required this.endData,
      required this.numberOfUse,
      required this.uploadDate, 
      required this.ownerCoupon, 
      required this.additionalTerms,
       this. storeLogoURL
      });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Title':title,
      'Code':code,
      'CouponId': couponId,
      'DiscountRate': discountRate,
      'StoreLink': storeLink,
      'Category': category?.toJson(),
      'EndDate': endData,
      'NumberOfUse': numberOfUse,
      'AdditionalTerms': additionalTerms,
      'StoreLogoURL':storeLogoURL,
      'UploadDate':uploadDate,
      'OwnerCoupon':ownerCoupon.toJson(),
      'OwnerCouponId':ownerCouponId,
      'CategoryID':category?.categoryId ?? "PI6L0IN9nDARotHfJNaW"

    };
  }

    factory Coupon.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return Coupon.empty();
    return Coupon(code: data["Code"],
     title: data["Title"], 
     couponId: data["CouponId"],
      discountRate: data["DiscountRate"], 
      storeLink: data["StoreLink"], 
      category: CategoryModel.fromJson(data["Category"]),
       endData: data["EndDate"], 
       numberOfUse: data["NumberOfUse"],
        additionalTerms: data["AdditionalTerms"],
        storeLogoURL: data["StoreLogoURL"],
        ownerCouponId: data["OwnerCouponId"],
         uploadDate: data["UploadDate"] ?? Timestamp.now(),
          ownerCoupon: UserModel.fromJson(data["OwnerCoupon"]),
         categoryID:data["CategoryID"]

        );
  }

  factory Coupon.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return Coupon(
        code: data["Code"],
        title: data["Title"],
        storeLogoURL :data["StoreLogoURL"],
          couponId: document.id,
          discountRate: data["DiscountRate"],
          storeLink: data["StoreLink"],
          category: CategoryModel.fromJson(data["Category"]),
          endData: data["EndDate"] is Timestamp 
        ? data["EndDate"] 
        : Timestamp.now(), // Handling possible non-Timestamp
          numberOfUse: data["NumberOfUse"],
          additionalTerms: data["AdditionalTerms"],
          ownerCouponId:data["OwnerCouponId"],
           categoryID:data["CategoryID"],
           uploadDate: data["UploadDate"] ?? Timestamp.now(),
            ownerCoupon: UserModel.fromJson(data["OwnerCoupon"]) 
          );
    } else {}
    return Coupon.empty();
  }

  static Coupon empty() => Coupon(
      couponId: "",
      code: "",
      discountRate: "",
      storeLink: "",
      category: CategoryModel.empty(),
      endData: Timestamp.now(),
      numberOfUse: 0,
      additionalTerms: "", 
      title: '',
      categoryID: "",
      // userIDAdded: "",
      // mobileNumberOwner: "",
      // emailNumberOwner: "",
       uploadDate: Timestamp.now(), ownerCoupon: UserModel.empty(), ownerCouponId: '');
}
