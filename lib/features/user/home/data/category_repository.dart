import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/services/fireabse_storage_services.dart';
import 'package:acwadcom/models/category_model.dart';
import 'package:acwadcom/models/offer_model.dart';

class CategoryRepository {
  // static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  ///Get all categories
  Future<List<CategoryModel>> getAllCategories()async {
    try {
      //we will receive some snapshot from the fire store
    final snapshot = await _db.collection('Categories').get();
    final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
    return list;
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
  ///Get sub Categories
  Future<List<CategoryModel>> getSubCategories(String categoryId)async {
    try {
      //we will receive some snapshot from the fire store
    final snapshot = await _db.collection('Categories').where('ParentId',isEqualTo: categoryId).get();
    final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
    return list;
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


  Future<List<OfferModel>> getTheOffers()async{
    try{
      final ref = await _db.collection("Offers").get();
      final offers = ref.docs.map((offer) => OfferModel.fromSnapshot(offer)).toList();
      return offers;
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
  
  ///Upload Categories to cloud firebase
  Future<void> uploadDummyData(List<CategoryModel> categories)async {
    try {
      //upload all categories along with their images
      final storage = getIt<TFirebaseStorageService>();
      

      //loop through each category
      for(var category in categories){
        //Get Image data link form the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        //upload image and Get its URL
        final url = await storage.uploadImageData('Categories', file, category.title["en"]);

        //Assign URL to Category.image attribute
        category.image = url;
        //store category in firebase
        await _db.collection('Categories').doc(category.categoryId).set(category.toJson());

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




}