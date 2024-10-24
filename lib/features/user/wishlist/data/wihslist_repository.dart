import 'dart:convert';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WihslistRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<Coupon>> feathcoWishList() async {
    try {
           // Get the current date and time
  DateTime currentDate = DateTime.now();
  Timestamp currentTimestamp = Timestamp.fromDate(currentDate);
      final userId = getIt<CacheHelper>().getValueWithKey("userID");
      final ref = await _db
          .collection("Users")
          .doc(userId)
          .collection("wishlist").where('EndData', isGreaterThan: currentTimestamp)
          .get();
      final coupons =
          ref.docs.map((document) => Coupon.fromSnapshot(document)).toList();
      return coupons;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

    Future<bool> isWishListStore(String storeID) async {
    try {
      final userId = getIt<CacheHelper>().getValueWithKey("userID");
      final ref =  _db
          .collection("Users")
          .doc(userId)
          .collection("wishlistStores")
          .doc(storeID);

          final docSnapshot = await ref.get();

          if(docSnapshot.exists){
            return true;
          }else{
            return false;
          }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }



  Future<void> addCouponToWishList(Coupon coupon) async {
    try {
      final userId = getIt<CacheHelper>().getValueWithKey("userID");
      await _db
          .collection("Users")
          .doc(userId)
          .collection("wishlist")
          .doc(coupon.couponId)
          .set(coupon.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> removeCouponFromWishList(Coupon coupon) async {
    try {
      final userId = getIt<CacheHelper>().getValueWithKey("userID");
      await _db
          .collection("Users")
          .doc(userId)
          .collection("wishlist")
          .doc(coupon.couponId)
          .delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

    Future<List<UserModel>> featchWishListForStores() async {
    try {
      final userId = getIt<CacheHelper>().getValueWithKey("userID");
      final ref = await _db
          .collection("Users")
          .doc(userId)
          .collection("wishlistStores")
          .get();
      final coupons =
          ref.docs.map((document) => UserModel.fromSnapshot(document)).toList();
      return coupons;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> addStoreToWishList(UserModel store) async {
    try {
      final userId = getIt<CacheHelper>().getValueWithKey("userID");
      await _db
          .collection("Users")
          .doc(userId)
          .collection("wishlistStores")
          .doc(store.id)
          .set(store.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

   Future<void> removeStoreFromWishList(UserModel store) async {
    try {
      final userId = getIt<CacheHelper>().getValueWithKey("userID");
      await _db
          .collection("Users")
          .doc(userId)
          .collection("wishlistStores")
          .doc(store.id)
          .delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
