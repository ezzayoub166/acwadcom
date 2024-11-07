import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/models/user_model.dart';

class StoreRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String collectionNameUsers = 'Users';

  Future<List<UserModel>> featchStores() async {
    try {
      final ref = await _db
          .collection(collectionNameUsers)
          .where('userType', isEqualTo: "STOREOWNER")
          .get();
      final stores =
          ref.docs.map((store) => UserModel.fromSnapshot(store)).toList();
      return stores;
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

  Future<List<UserModel>> featchSpecialStores() async {
    try {
      final ref = await _db
          .collection(collectionNameUsers)
          .where('userType', isEqualTo: "STOREOWNER")
          .where("isFeaturedStore", isEqualTo: true)
          .limit(10)
          .get();
      final stores =
          ref.docs.map((store) => UserModel.fromSnapshot(store)).toList();
      return stores;
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

  //fetch
  Future<List<Coupon>> fetchCouponForSelectStore(String ownerID) async {
    try {
      // Get the current date and time
      DateTime currentDate = DateTime.now();
      Timestamp currentTimestamp = Timestamp.fromDate(currentDate);
      final ref = await _db
          .collection("Coupons")
          .where("OwnerCouponId", isEqualTo: ownerID)
          .where('EndDate', isGreaterThan: currentTimestamp)

          .get();
      final coupons =
          ref.docs.map((coupon) => Coupon.fromSnapshot(coupon)).toList();
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
      print(e.toString());
      throw 'something went wrong. Please try again';
    }
  }
}
