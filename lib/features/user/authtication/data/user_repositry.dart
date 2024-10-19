
import 'dart:io';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/data/authentication_repository.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:flutter/foundation.dart';




class UserRepository {


  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String collectionNameUsers = 'Users';


   ///!! Not Sure Here .....
  final _currentAuthUser =  getIt<AuthenticationRepository>().authUser;
  


  ///Function to save user data to fireStore

   Future<void> storeUserRecord(UserModel user)async {
     try{
       await _db.collection(collectionNameUsers).doc(user.id).set(user.toJson());
     }on FirebaseAuthException catch (e){
       throw TFirebaseAuthException(e.code).message;
     }on FirebaseException catch (e){
       throw TFirebaseException(e.code).message;
     }on FormatException catch (_){
       throw TFormatException();
     }on PlatformException catch (e){
       throw TPlatformException(e.code).message;
     }catch(e){
       throw 'something went wrong. Please try again';
     }

   }

   ///Function to fetch user details based on user ID

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection(collectionNameUsers).doc(_currentAuthUser?.uid).get();
      if (documentSnapshot.exists) {
        print("Exist");
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        print("Not Exist");
        return UserModel.empty();
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


//Fucntion For me ..
  Future<UserModel> fetchStableData(userID) async {
    try {
      final documentSnapshot = await _db.collection(collectionNameUsers).doc(userID).get();
      if (documentSnapshot.exists) {
        print("Exist");
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        print("Exist");
        return UserModel.empty();
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

  ///Function to update user Data in FireStore
  Future<void> updateUserDetails(UserModel updateUser)async {
    try {
      await _db.collection(collectionNameUsers).doc(updateUser.id).update(updateUser.toJson());
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

  ///Function to update any filed in Specific users Collection
  Future<void> updateStringFiled(Map<String , dynamic> json)async {
    try {
      await _db.collection(collectionNameUsers).doc(_currentAuthUser?.uid).update(json);
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

  ///Function to update user Data in fireStore
  Future<void> removeUserRecord(String userID)async {
    try {
      await _db.collection(collectionNameUsers).doc(userID).delete();
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

     ///save user Record from any Registration Provider
   Future<dynamic> saveUserRecord(UserCredential? userCredential)async{
    //First update Rx user and then check if user data is already stored . if not store user data.
      UserModel user = await fetchUserDetails();    //if no record already stored
    if(user.id.isEmpty){
      try{
        if(userCredential != null){
          //convert name to First and Last Name
          // final nameParts = UserModel.nameParts(userCredential.user!.displayName ?? '');
          final userName = UserModel.generateUserName(userCredential.user!.displayName ?? '');

          //Map Data
          final user = UserModel(
              id: userCredential.user!.uid,
              userName: userName,
              email: userCredential.user!.email ?? '',
              phoneNumber: userCredential.user!.phoneNumber ?? '',
              profilePicture: userCredential.user!.photoURL ?? '', userType: "USER",storeLink: "");

          await storeUserRecord(user);
          return user;
        }
      }
      catch(e){
        // TLoader.warningSnackBar(title: 'Date not saved',
        //     message: 'Something is Wrong'
        // );
        if (kDebugMode) {
          print(e.toString());
        }
         throw 'something went wrong. Please try again';

      }
    }

   }



}