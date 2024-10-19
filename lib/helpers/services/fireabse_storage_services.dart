import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
// import 'package:e_commerce_app/utils/constants/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class TFirebaseStorageService {
  // static TFirebaseStorageService get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  /// Generate MD5 hash of the image data
  String generateMD5(Uint8List imageData) {
    var digest = md5.convert(imageData);
    return digest.toString(); // This is the unique identifier
  }

  /// Check if the image is already uploaded by its hash (MD5)
  Future<bool> doesImageExist(String path, String imageHash) async {
    try {
      // Try to get metadata of the file to check if it exists
      final ref = _firebaseStorage.ref(path).child(imageHash);
      await ref.getMetadata();
      return true; // Image exists
    } catch (e) {
      // If the image does not exist, Firebase will throw an error
      return false; // Image does not exist
    }
  }

  ///Upload Local Assets from IDE
  ///Returns a Unit8List containing image data.
  Future<Uint8List> getImageDataFromAssets(String path) async{
    try{

      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes,byteData.lengthInBytes);
      return imageData;
    }catch(e){
      //Handel exception
      throw 'Error Loading image data: $e';
    }
  }

  ///Upload Image Data
  ///Returns the download URL of the uploaded image
  Future<String> uploadImageData(String path , Uint8List image , String name)async{
    try{
      final imageHash = generateMD5(image); // Generate MD5 hash

      // Check if the image already exists in Firebase Storage
      bool exists = await doesImageExist(path, imageHash);
      if (exists) {
        // If it exists, return the URL without re-uploading
        final ref = _firebaseStorage.ref(path).child(imageHash);
        print("this image is exist");
        return await ref.getDownloadURL();
      }

      // If the image doesn't exist, upload it
      final ref = _firebaseStorage.ref(path).child(imageHash);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;

      // final ref = _firebaseStorage.ref(path).child(name);
      // await ref.putData(image);
      // final url = await ref.getDownloadURL();
      // return url;
    }catch(e){
      if(e is FirebaseException){
        throw 'Firebase Exception: ${e.message}';
      }else if (e is SocketException){
        throw 'Network Error: ${e.message}';
      }else if (e is PlatformException){
        throw 'Platform Exception: ${e.message}';
      }else{
        throw 'Something went Wrong! Please try again';
      }
    }
  }

  ///upload image on cloud Firebase storage
  ///Returns the download URL of the uploaded image
  Future<String> uploadImageFile(String path , XFile image)async{
    try{
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    }catch(e){
      if(e is FirebaseException){
        throw 'Firebase Exception: ${e.message}';
      }else if (e is SocketException){
        throw 'Network Error: ${e.message}';
      }else if (e is PlatformException){
        throw 'Platform Exception: ${e.message}';
      }else{
        throw 'Something went Wrong! Please try again';
      }
    }
  }

}