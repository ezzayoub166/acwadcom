import 'package:acwadcom/models/coupon_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CouponRequest {
  final Coupon coupon;
  final String requestedBy; // User ID of the person who added the request
  // final String ownerId; // Owner's ID to whom the request is sent
  final String status; // Status of the request, e.g., pending, approved, rejected

  CouponRequest({
    required this.coupon,
    required this.requestedBy,
    // required this.ownerId,
    this.status = 'pending',
  });

  Map<String, dynamic> toJson() {
    return {
      'couponData': coupon.toJson(),
      'requestedBy': requestedBy,
      // 'ownerId': ownerId,
      'status': status,
    };
  }

  factory CouponRequest.fromJson(Map<String, dynamic> json) {
    return CouponRequest(
      coupon: Coupon.fromSnapshot(json['couponData']),
      requestedBy: json['requestedBy'],
      // ownerId: json['ownerId'],
      status: json['status'],
    );
  }

  factory CouponRequest.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if(document.data() != null){
      final data = document.data()!;
      return CouponRequest(coupon: Coupon.fromJson(data["couponData"]),
       requestedBy: data["requestedBy"],
        status: data["status"]
        );
    }else{
      return CouponRequest.empty();
    }
    
  }

  factory CouponRequest.empty(){
    return CouponRequest(coupon: Coupon.empty() , requestedBy: "" , status: "pending");
  }
}
