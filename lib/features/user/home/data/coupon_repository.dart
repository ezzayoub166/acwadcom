import 'dart:io';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/models/coupon_request.dart';

class CouponRepository {
  final _db = FirebaseFirestore.instance;

  final couponsConstant = "Coupons";
  final couponsRequestConstant = "couponsRequests";


  ///Upload any image
  Future<String> uploadImage(String path, File image) async {
    try {
            final mimeType = getMimeType(image);
      final metadata = SettableMetadata(contentType: mimeType);
        // Generate a unique ID for the image
       final imageId = FirebaseFirestore.instance.collection('images').doc().id;

       // Create a storage reference
    final refStorage = FirebaseStorage.instance.ref().child('images').child(imageId);

     // Upload the file
    final uploadTask = refStorage.putFile(image, metadata);

        // Track the upload progress
  
  


    // Wait for the upload to complete
    final snapshot = await uploadTask.whenComplete(() {});

    // Get the download URL for the uploaded image
    final imageUrl = await snapshot.ref.getDownloadURL();
    // print("Image URL: $imageUrl");

    return imageUrl;


      // final ref = FirebaseStorage.instance.ref(path).child(image.name);
      // await ref.putFile(File(image.path));
      // final url =
      //     await ref.getDownloadURL(); // use this url to display this image ..
      // return url;
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

  Future<List<Coupon>> fetchDiscoverCoupons() async {
    try {
      // Get the current date and time
      DateTime currentDate = DateTime.now();
      Timestamp currentTimestamp = Timestamp.fromDate(currentDate);
      final ref = await _db
          .collection(couponsConstant)
          .where('EndDate', isGreaterThan: currentTimestamp)
          .limit(10)
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
      throw 'something went wrong. Please try again';
    }
  }

  Future<Coupon> fetchCouponById(String couponID)async{
      try {
      // Get the current date and time

      final documentSnapshot = await _db
          .collection(couponsConstant)
          .doc(couponID)
          .get();
      if (documentSnapshot.exists) {
        return Coupon.fromSnapshot(documentSnapshot);
      } else {
        return Coupon.empty();
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
      throw 'something went wrong. Please try again';
    }
  }

  Future<List<Coupon>> fetchAllCoupons() async {
    try {
      // Get the current date and time
      DateTime currentDate = DateTime.now();
      Timestamp currentTimestamp = Timestamp.fromDate(currentDate);
      final ref = await _db
          .collection(couponsConstant)
          .where('EndDate', isGreaterThan: currentTimestamp)
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
      throw 'something went wrong. Please try again';
    }
  }

    Future<List<Coupon>> fetchCouponsByCategory(String categoryID) async {
    try {
      // Get the current date and time
      DateTime currentDate = DateTime.now();
      Timestamp currentTimestamp = Timestamp.fromDate(currentDate);
      final ref = await _db
          .collection(couponsConstant)
          .where('EndDate', isGreaterThan: currentTimestamp)
          .where("CategoryID",isEqualTo: categoryID)
          .limit(7)
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
      throw 'something went wrong. Please try again';
    }
  }

   Future<List<Coupon>> fetchAllCouponsForAdmin() async {
    try {

      final ref = await _db
          .collection(couponsConstant)
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
      throw 'something went wrong. Please try again';
    }
  }

    // Fetch only the count of coupons without retrieving all the data
  Future<int> getCouponCount() async {
    try {
      // Get the count of documents in the Coupons collection
      final snapshot = await _db.collection('Coupons').count().get();
      return snapshot.count ?? 0;  // Return the document count
    } catch (e) {
      throw 'Error getting coupon count: $e';
    }
  }



  Future<List<Coupon>> fetchRecentlyAddedCoupons(int limit) async {
    try {
      // Get the current date and time
      DateTime currentDate = DateTime.now();
      Timestamp currentTimestamp = Timestamp.fromDate(currentDate);

      // Query the Firestore collection for coupons that have not expired
      // and order them by uploadDate in descending order to get the most recent first
      final ref = await _db
          .collection(couponsConstant)
          .where('EndDate', isGreaterThan: currentTimestamp)
          .get();

      // Convert the documents into Coupon objects
      final coupons =
          ref.docs.map((document) => Coupon.fromSnapshot(document)).toList();


 // Sort the coupons locally by uploadDate in descending order
      coupons.sort((a, b) => b.uploadDate.compareTo(a.uploadDate));

      final filterCoupons = coupons.take(limit).toList();


        
      // Return only the most recent 10 coupons
      return filterCoupons;
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

  Future<List<Coupon>> fetchMostUsedCoupons() async {
    try {
      // Get the current date and time
      DateTime currentDate = DateTime.now();
      Timestamp currentTimestamp = Timestamp.fromDate(currentDate);

      // Query the Firestore collection for coupons that have not expired
      // and order them by uploadDate in descending order to get the most recent first
      final ref = await _db
          .collection(couponsConstant)
          .where('EndDate', isGreaterThan: currentTimestamp)
          .where("NumberOfUse" , isGreaterThanOrEqualTo: 50)
          .limit(6)
          .get();

      // Convert the documents into Coupon objects
      final coupons =
          ref.docs.map((document) => Coupon.fromSnapshot(document)).toList();

      // Sort locally by uploadDate in descending order
      coupons.sort((a, b) => b.uploadDate.compareTo(a.uploadDate));

      // Return only the most recent 10 coupons
      return coupons.toList();
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


  //** Done Fetch Coupons For Owner. */

  Future<List<Coupon>> fetchCouponsForOwner() async {
    try {
      final storeOwnerId = getIt<CacheHelper>().getValueWithKey("userID");
      // Get the current date and time
      DateTime currentDate = DateTime.now();
      Timestamp currentTimestamp = Timestamp.fromDate(currentDate);

      final ref = await _db
          .collection(couponsConstant)
           .where("OwnerCouponId", isEqualTo: storeOwnerId)
          .where('EndDate', isGreaterThan: currentTimestamp)
         
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
      throw 'something went wrong. Please try again';
    }
  }

  //** Delete Coupon For Owner. */

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

    //** Delete All Coupons For Owner when Delete the store. */
  Future<void> removeCoupons(String userID) async {
    try {
      // Remove the coupon documents from Firestore using the ownerCouponId
      QuerySnapshot couponsSnapshot = await _db.collection(couponsConstant).where('OwnerCouponId', isEqualTo: userID).get();
      for (DocumentSnapshot coupon in couponsSnapshot.docs) {
        await coupon.reference.delete();
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
  
  ///Function to update any filed in Specific users Collection
  Future<void> updateStringFiled(
      {required Map<String, dynamic> json, required String couponID}) async {
    try {
      await _db.collection(couponsConstant).doc(couponID).update(json);
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
      throw 'something went wrong. Please try again';
    }
  }

  // Approve a coupon request
  Future<void> approveCouponRequest(Coupon coupon) async {
    // Add the coupon to the "acceptedCoupons" collection
    try {
      await Future.wait([
        _db.collection('Coupons').doc(coupon.couponId).set(coupon.toJson()),

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

  Future<void> rejectCouponRequest(Coupon coupon) async {
    try {
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

  Future<List<Coupon>> filterCoupons(
      {required String categoryID, required int rate}) async {
    try {
      DateTime currentDate = DateTime.now();
      Timestamp currentTimestamp = Timestamp.fromDate(currentDate);
      // print(currentTimestamp);
      final ref = await _db
          .collection(couponsConstant)
          .where("CategoryID", isEqualTo: categoryID)
          .where("DiscountRate", isEqualTo: rate.toString())
          .where('EndDate', isGreaterThan: currentTimestamp)
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
    } catch (onError) {
      throw 'something went wrong. Please try again : ${onError}';
    }
  }

    ///Function to update any filed in Specific users Collection
  Future<void> updateStringFiledForCoupon(Map<String, dynamic> json , String userID) async {
    try {
          // Step 1: Fetch all documents where "OwnerCouponId" matches the given userID

        final querySnapshot = await _db
          .collection(couponsConstant)
          .where("OwnerCouponId" , isEqualTo: userID).get();

              // Step 2: Iterate through each document and update it
        for (final doc in querySnapshot.docs) {
         await _db.collection(couponsConstant).doc(doc.id).update(json);
       }

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong. Please try again';
    }
  }

  // Approve a coupon request
  Future<void> updateCoupon(Coupon coupon) async {
    // Add the coupon to the "acceptedCoupons" collection
    try {
      await
        _db.collection('Coupons').doc(coupon.couponId).update(coupon.toJson());
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
