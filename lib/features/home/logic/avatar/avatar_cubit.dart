import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/services/cachce_services/chache_helper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'avatar_state.dart';
part 'avatar_cubit.freezed.dart';

class AvatarCubit extends Cubit<AvatarState> {
  AvatarCubit() : super(const AvatarState.fetchNameImage(username: "", imageUrl: ""));

  void loadProfileData() async{
    // Get values from CacheHelper
    var username = await getIt<CacheHelper>().getValueWithKey("USERNAME") ?? "";
    var imageUrl = await getIt<CacheHelper>().getValueWithKey("IMAGEURL") ?? "";
    
    // Emit new state
    emit(AvatarState.fetchNameImage(username: username, imageUrl: imageUrl));
  }
}