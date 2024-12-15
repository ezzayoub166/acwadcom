// ignore_for_file: prefer_const_constructors
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/UI/widgets/login_bloc_listener.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/user/home/logic/avatar/avatar_cubit.dart';
import 'package:acwadcom/features/user/settings/logic/cubit/profile_cubit.dart';
import 'package:acwadcom/features/user/settings/ui/widgets/build_abled_textfiled.dart';
import 'package:acwadcom/features/user/settings/ui/widgets/build_disabled_textfiled.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProfileCubit>(context).emitLoadingProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBarWithBackButton(context, isRTL(context)),
        body: BlocBuilder<ProfileCubit, ProfileState>(
                  buildWhen: (previous, current) =>
          current is ChangePictureImageSuccess ||
          current is ProfileSuccess ||
          current is ProfileError ||
          current is ChangePictureImageError,
                  builder: (context, state) {
        return state.maybeWhen(
            // profileLoading: () => Center(child: CircularProgressIndicator()),
            profileError: (error) {
              // Use addPostFrameCallback to ensure the widget tree has been built
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setupErrorState(context, error);
              });
              return Center(
                  child: Text('An error occurred')); // Return a widget
            },
            changePictureImageSuccess: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                TLoader.showSuccessSnackBar(
                  context,
                  title: 'Success',
                  message: 'Profile image updated!',
                );
        
                // Reload profile to get the latest data
                context.read<ProfileCubit>().emitLoadingProfileData();
                // Emit new AvatarState to update other pages
                context.read<AvatarCubit>().loadProfileData();
                // user.value.profilePicture = imageURl;
              });
        
              return SizedBox
                  .shrink(); // Return an empty widget as we're only triggering UI side effects
            },
            changePictureImageError: (error) {
              // Use addPostFrameCallback to ensure the widget tree has been built
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setupErrorState(context, error);
              });
              return Center(child: Text('An error occurred'));
            },
            profileSuccess: (user) {
              // Set initial values for controllers
              context.read<ProfileCubit>().nameC.text = user.userName;
              context.read<ProfileCubit>().mobileNumberC.text =
                  user.phoneNumber;
              return SingleChildScrollView(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                                                  
                        children: [
                          Stack(
                            children: [
                              // CircleAvatar with image
                              BlocBuilder<ProfileCubit, ProfileState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    profileSuccess: (user) {
                                      // Evict the cached image when the profile picture changes
                                      if (user.profilePicture.isNotEmpty) {
                                        CachedNetworkImageProvider(
                                                user.profilePicture)
                                            .evict();
                                      }
        
                                      return CircleAvatar(
                                        radius: 50,
                                        backgroundImage: user
                                                .profilePicture.isEmpty
                                            ? AssetImage(
                                                "assets/images/user.png")
                                            : CachedNetworkImageProvider(
                                                user.profilePicture),
                                      );
                                    },
                                    orElse: () => Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                              ),
        
                              // Positioned widget to place the edit icon at the bottom right
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    // Handle the image edit action here
                                    context
                                        .read<ProfileCubit>()
                                        .uploadUserProfilePicture();
                                  },
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: ManagerColors
                                        .kCustomColor, // Background color for edit icon circle
                                    child: Icon(
                                      Icons.edit, // The edit icon
                                      color: Colors.white, // Icon color
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          myText(
                            user.userName,
                            fontSize: 16,
                            color: ManagerColors.kCustomColor,
                            fontWeight: FontWeightEnum.Bold.fontWeight,
                          ),
                          buildSpacerH(5.0),
                          myText(AText.user.tr(context),
                              fontSize: 16,
                              fontWeight: FontWeightEnum.Bold.fontWeight,
                              color: ManagerColors.yellowColor),
                          buildSpacerH(10.0),
                          Form(
                            key: context.read<ProfileCubit>().formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildAbleTextField(
                                  hintText: AText.username.tr(context),
                                    controller:
                                        context.read<ProfileCubit>().nameC,
                                    // text: user.userName,
                                    validator: (value) =>
                                        ManagerValidator.validateEmptyText(
                                           "username", value??"",context)),
                                buildSpacerH(10.0),
                                buildAbleTextField(
                                  hintText: AText.phoneNumber.tr(context),
                                  
                                    controller: context
                                        .read<ProfileCubit>()
                                        .mobileNumberC,
                                    // text: user.phoneNumber,
                                    validator: (value) =>
                                        ManagerValidator.validateEmail(
                                            value, context)),
                                buildSpacerH(10.0),
                                buildDisabledTextField(
                                  text: user.email,
        
                                  // validator: (value) =>
                                  //     ManagerValidator.validateEmail(
                                  //         value, context)
                                ),
                                buildSpacerH(10.0),
                                RoundedButtonWgt(
                                    width: double.infinity,
                                    fontSize: 16,
                                    title: AText.save.tr(context),
                                    onPressed: () {
                                      //!! For Editing the Data For user ..........
                                      context.read<ProfileCubit>().updateUserData();
                                      
                                    })
                              ],
                            ),
                          ),
                        ])),
              );
            },
            orElse: () => Center(child: CircularProgressIndicator()));
                  },
                ));
  }

}
