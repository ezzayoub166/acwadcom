// ignore_for_file: prefer_const_constructors, empty_catches

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/authtication/data/authentication_repository.dart';
import 'package:acwadcom/features/authtication/data/user_repositry.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/util/t_formater.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {


  final AuthenticationRepository _authenticationRepository;

  
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();



  RegisterCubit(this._authenticationRepository) : super(RegisterState.initial());


  void emitRegisterStates() async{
    try {
    emit(RegisterState.registerLoading());

    //register User 
    final userCredential = await _authenticationRepository.registerWithEmilAndPassword(emailController.text.trim(), passwordController.text.trim());

    //Save in Firebase Firestore 
    final newUser = UserModel(id: userCredential.user!.uid, userName: nameController.text.trim(), email: emailController.text.trim(), phoneNumber: phoneController.text.trim(), profilePicture: "");
    final userRepostiry = getIt<UserRepository>();
    await userRepostiry.storeUserRecord(newUser);
    emit(RegisterState.registerSuccess());
    }catch(error){
      emit(RegisterState.registerError(error: error.toString()));
      print(error.toString());
    }

  }
}



class UserModel {
  final String id;
  // String firstName;
  // String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "phoneNumber": phoneNumber,
      "profilePicture": profilePicture,
    };
  }

  UserModel(
      {required this.id,
      // required this.firstName,
      // required this.lastName,
      required this.userName,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture});

  ///Helper Function to get FullName
  // String get fullName => '$firstName $lastName';

  ///Helper Function to format phone Number
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(fullName) => fullName.spilt(" ");

  ///static function to generate a username from the full Name

  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName = '$firstName$lastName';
    String userNameWithPrefix = 'cwt_$camelCaseUserName';
    return userNameWithPrefix;
  }

  ///static function to create on empty user model
  static UserModel empty() => UserModel(
      id: '',
      // firstName: '',
      // lastName: '',
      userName: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  ///Factory method to create a UserModel from a Firebase snapshot.

   factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> doc){
     if(doc.data() != null) {
       return UserModel(
           id: doc.id,
          //  firstName: doc["firstName"] ?? "",
          //  lastName: doc["lastName"] ?? "",
           userName: doc["userName"] ?? "",
           email: doc["email"] ?? "",
           phoneNumber: doc["phoneNumber"] ?? "",
           profilePicture: doc["profilePicture"] ?? "");
     }
       else{
         return UserModel.empty();
     }
   }
}
