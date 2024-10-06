import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/authtication/data/user_repositry.dart';
import 'package:acwadcom/features/authtication/logic/register/cubit/register_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userRepository) : super(ProfileState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final UserRepository _userRepository;
  // UserModel user;


  Future<void> emitLoadingProfileData() async {
  try {
    // Emit loading state before starting the fetch operation
    emit(const ProfileState.profileLoading());

    // Fetch user details from repository
    final user = await _userRepository.fetchUserDetails();

    // If the fetch is successful, emit the loaded state with the user data
    emit(ProfileState.profileSuccess(user: user));
  } catch (e) {
    // If an error occurs, emit the error state with the error message
    emit(ProfileState.profileError(error: e.toString()));
  }
}

  


}
