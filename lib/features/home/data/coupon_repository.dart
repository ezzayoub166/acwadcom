import 'dart:io';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CouponRepository{

  final _db = FirebaseFirestore.instance;

  final couponsConstant = "Coupons";

  

  Future<void> addCoupon(Coupon coupon)async{
    try{
    await _db.collection(couponsConstant).doc(coupon.couponId).set(coupon.toJson());
    }on FirebaseAuthException catch (e) {
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

  ///Upload any image
   Future<String> uploadImage(String path , XFile image)async{
      try {
        final ref = FirebaseStorage.instance.ref(path).child(image.name);
        await ref.putFile(File(image.path));
        final url = await ref.getDownloadURL(); // use this url to display this image ..
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


   Future<List<Coupon>> fetchCoupons()async{
    try{
      final ref = await _db.collection(couponsConstant).get();
      final coupons = ref.docs.map((document) => Coupon.fromSnapshot(document)).toList();
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
   

//    Stream<List<Coupon>> fetchCouponsStream() {
//   return FirebaseFirestore.instance.collection('coupons')
//     .snapshots()
//     .map((snapshot) {
//       return snapshot.docs.map((doc) => Coupon.fromSnapshot(doc)).toList();
//     });
// }




}