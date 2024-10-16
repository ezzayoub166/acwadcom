import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/models/coupon_request.dart';

class CouponRequestService {
  final db = FirebaseFirestore.instance;

  //Send a coupon request to owner 
  Future<void> snedCouponRequest({required Coupon coupon , required String userID})async{
    try{
    final request = CouponRequest(coupon: coupon, requestedBy: userID);
    await db.collection("couponsRequests").add(request.toJson());
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
}