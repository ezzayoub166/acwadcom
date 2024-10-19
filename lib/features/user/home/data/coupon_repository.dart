import 'dart:io';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/models/coupon_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CouponRepository {
  final _db = FirebaseFirestore.instance;

  final couponsConstant = "Coupons";
  final couponsRequestConstant = "couponsRequests";

  Future<void> removeCoupon(String couponId) async {
    try {
      // Remove the coupon document from Firestore using the couponId
      await _db.collection(couponsConstant).doc(couponId).delete();
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

  ///Upload any image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url =
          await ref.getDownloadURL(); // use this url to display this image ..
      return url;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong. Please try again';
    }
  }

  Future<List<Coupon>> fetchCoupons() async {
    try {
      final ref = await _db.collection(couponsConstant).get();
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
      print(e);
      throw 'something went wrong. Please try again';
    }
  }

  Future<List<CouponRequest>> fetchCouponsRequest() async {
    try {
      final ref = await _db.collection(couponsRequestConstant).get();
      final coupons = ref.docs
          .map((document) => CouponRequest.fromSnapshot(document))
          .toList();
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
      print(e);
      throw 'something went wrong. Please try again';
    }
  }

  Future<List<CouponRequest>> fetchCouponsRequestByOwnerID(
      String ownerID) async {
    try {
      final ref = await _db
          .collection(couponsConstant)
          .where("requestedBy", isEqualTo: ownerID)
          .get();
      final coupons = ref.docs
          .map((document) => CouponRequest.fromSnapshot(document))
          .toList();
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
      print(e);
      throw 'something went wrong. Please try again';
    }
  }

  // Approve a coupon request
  Future<void> approveCouponRequest(Coupon coupon) async {
    // Add the coupon to the "acceptedCoupons" collection
    try {
      await Future.wait([
        _db.collection('Coupons').add(coupon.toJson()),

        // Delete the coupon request from "couponsRequests"
        //the couponRequestId is same id for the coupon ...
        _db.collection('couponsRequests').doc(coupon.couponId).delete()
      ]);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // print(e);
      throw 'something went wrong. Please try again:${e}';
    }
  }

  Future<void> rejectCouponRequest(Coupon coupon)async{
    try{
       await _db.collection('couponsRequests').doc(coupon.couponId).delete();

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // print(e);
      throw 'something went wrong. Please try again:${e}';
    }
  }



  //Send a coupon request to owner
  Future<void> snedCouponRequest(
      {required Coupon coupon, required String userID}) async {
    try {
      final request = CouponRequest(coupon: coupon, requestedBy: userID);
      await _db
          .collection("couponsRequests")
          .doc(coupon.couponId)
          .set(request.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (onError) {
      throw 'something went wrong. Please try again : ${onError}';
    }
  }

//    Stream<List<Coupon>> fetchCouponsStream() {
//   return FirebaseFirestore.instance.collection('coupons')
//     .snapshots()
//     .map((snapshot) {
//       return snapshot.docs.map((doc) => Coupon.fromSnapshot(doc)).toList();
//     });
// }
}
