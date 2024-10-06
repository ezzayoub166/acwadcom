


// ignore_for_file: prefer_const_constructors
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';

import 'package:google_sign_in/google_sign_in.dart';


class AuthenticationRepository  {
  // static AuthenticationRepository get instance => Get.find();

  // final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;


  // ///Called from main.dart on app lunch
  // @override
  // void onReady() {
  //   // TODO: implement onReady
  //   FlutterNativeSplash.remove();
  //   screenRedirect();
  // }

  screenRedirect(context) async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        // await TLocalStorage.init(user.uid);
        // Get.offAll(() => NavigationMenu());
        getIt<CacheHelper>().saveValueWithKey("userID" , user.uid);
        navigateAndFinishNamed(context, Routes.bottomTabBarScreen);
      } else {
       navigateAndFinishNamed(context, Routes.verifyEmailScreen , _auth.currentUser?.email);
      }
    } else {
      getIt<CacheHelper>().getValueWithKey("OpenApp") != true ? navigateNamedTo(context, Routes.onBoardingScreen) :navigateNamedTo(context, Routes.chosenStatusScreen);

  }
  }

  // Updated _authenticationRepository.screenRedirect
// screenRedirect() async {
//   final user = _auth.currentUser;
//   if (user != null && user.emailVerified) {
//     getIt<CacheHelper>().saveValueWithKey("userID", user.uid);
//     return true; // Email verified and valid user
//   } else if (user != null && !user.emailVerified) {
//     return false; // Email not verified
//   } else {
//     return null; // User is null
//   }
// }

  /* ============================ Email & Password sing_in ============================ */
  ///[Email Authentication] = SignIn
  Future<UserCredential> loginWithEmilAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
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

  /// [Email Authentication] = REGISTER
  Future<UserCredential> registerWithEmilAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
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


  ///======================= SOCIAL  =======================
  Future<UserCredential?> singInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      //Create a new Credential

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,

      );

      //Once Signed in , return the UserCredential
      return _auth.signInWithCredential(credential);

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


  /// [Email Authentication] = MAIL Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
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

  /// [Email Authentication] = valid for any Authntication
 Future<void> logout()async{
   try {
     await GoogleSignIn().signOut();
     await _auth.signOut();
     getIt<CacheHelper>().removeValueWithKey("userID");
     isLoggedInUser = false;
      //!! Some Things Need to Edit 
    //  Get.offAll(() => LoginScreen());
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

  /// [Email Authentication] = RESET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async{
    try {
      await _auth.sendPasswordResetEmail(email: email);
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

  /// DELETE USER == Remove user Auth and fireStore Account.
  Future<void> deleteAccount()async{
    try {
      //!! Some Things Need to Edit 
      // await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
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

/// Re_Auth == Remove user Auth and fireStore Account.
  Future<void> reAuthenticateEmailAndPassword(String email , String password)async{
    try{
      //Create  Credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      //Re Auth
      await _auth.currentUser?.reauthenticateWithCredential(credential);
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




}
