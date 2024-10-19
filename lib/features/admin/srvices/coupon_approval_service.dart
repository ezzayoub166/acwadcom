import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/models/coupon_model.dart';

class CouponApprovalService {
  final _db = FirebaseFirestore.instance;

  // Approve a coupon request
  Future<void> approveCouponRequest(String requestId, Coupon coupon) async {
    // Add the coupon to the "acceptedCoupons" collection
    try {
      await Future.wait([
        _db.collection('Coupons').add({
          'couponData': coupon.toJson(),
        }),

        // Delete the coupon request from "couponsRequests"
        _db.collection('couponsRequests').doc(requestId).delete()
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
}
