import 'dart:io';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/data/authentication_repository.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as _path;

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String collectionNameUsers = 'Users';

  ///!! Not Sure Here .....
  final _currentAuthUser = getIt<AuthenticationRepository>().authUser;

  ///Function to save user data to fireStore

  Future<void> storeUserRecord(UserModel user) async {
    try {
      await _db.collection(collectionNameUsers).doc(user.id).set(user.toJson());
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

  ///Function to fetch user details based on user ID

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection(collectionNameUsers)
          .doc(_currentAuthUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
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
      final documentSnapshot =
          await _db.collection(collectionNameUsers).doc(userID).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
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

  Future<bool> checkIFLoggedBefore(userID) async {
    try {
      final documentSnapshot =
          await _db.collection(collectionNameUsers).doc(userID).get();

      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
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
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection(collectionNameUsers)
          .doc(updateUser.id)
          .update(updateUser.toJson());
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
  Future<void> updateStringFiled(Map<String, dynamic> json) async {
    String currentUserID = getIt<CacheHelper>().getValueWithKey("userID");
    try {
      await _db
          .collection(collectionNameUsers)
          .doc(currentUserID)
          .update(json);
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
  Future<void> removeUserRecord(
      String userID, String email, String password) async {
    try {
      await _db.collection(collectionNameUsers).doc(userID).delete();
      // Reauthenticate the user
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await _currentAuthUser?.reauthenticateWithCredential(credential);
      // Delete user from Firebase Authentication
      await _currentAuthUser?.delete();
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

    //     // Track the upload progress
    // uploadTask.snapshotEvents.listen((taskSnapshot) {
    //   switch (taskSnapshot.state) {
    //     case TaskState.running:
    //       final progress = (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes) * 100;
    //       print('Upload is $progress% complete');
    //       // Show progress indicator (e.g., with a library like `flutter_progress_hud`)
    //       break;
    //     case TaskState.success:
    //       print("Upload complete");
    //       break;
    //     case TaskState.error:
    //       // Handle errors during upload
    //       print("Upload failed: ${taskSnapshot.state}");
    //       break;
    //     default:
    //       break;
    //   }
    // });

    // Wait for the upload to complete
    final snapshot = await uploadTask.whenComplete(() {});

    // Get the download URL for the uploaded image
    final imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;

      // // Extract file name from the file path
      // final fileName = _path.basename(image.path);


      // final ref = FirebaseStorage.instance.ref(path).child(fileName);
      // await ref.putFile(image);
      // final url =
      //     await ref.getDownloadURL(); // Use this URL to display the image
      // return url;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin, message: e.message);
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }


   ///Upload any image
  Future<String> uploadImageWithXFile(String path, XFile image) async {
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

  ///save user Record from any Registration Provider
  Future<dynamic> saveUserRecord(UserCredential? userCredential) async {
    //First update Rx user and then check if user data is already stored . if not store user data.
    UserModel user = await fetchUserDetails(); //if no record already stored
    if (user.id.isEmpty) {
      try {
        if (userCredential != null) {
          //convert name to First and Last Name
          // final nameParts = UserModel.nameParts(userCredential.user!.displayName ?? '');
          final userName = UserModel.generateUserName(
              userCredential.user!.displayName ?? '');

          //Map Data
          final user = UserModel(
              id: userCredential.user!.uid,
              userName: userName,
              email: userCredential.user!.email ?? '',
              phoneNumber: userCredential.user!.phoneNumber ?? '',
              profilePicture: userCredential.user!.photoURL ?? '',
              userType: tYPEUSER,
              storeLink: "");

          await storeUserRecord(user);
          return user;
        }
      } catch (e) {
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
