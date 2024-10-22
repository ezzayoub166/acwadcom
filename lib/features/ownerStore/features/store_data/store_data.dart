// // ignore_for_file: prefer_const_constructors
// import 'package:acwadcom/acwadcom_packges.dart';
// import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
// import 'package:acwadcom/features/user/home/logic/avatar/avatar_cubit.dart';
// import 'package:acwadcom/features/user/settings/logic/cubit/profile_cubit.dart';
// import 'package:acwadcom/features/user/settings/ui/widgets/build_abled_textfiled.dart';

// class StoreDataScreen extends StatefulWidget {
//   const StoreDataScreen({super.key});

//   @override
//   State<StoreDataScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<StoreDataScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     BlocProvider.of<ProfileCubit>(context).emitLoadingProfileData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: buildAppBarWithBackButton(context, isRTL(context)),
//         body: Center(
//             child: BlocBuilder<ProfileCubit, ProfileState>(
//           buildWhen: (previous, current) =>
//               current is ChangePictureImageSuccess ||
//               current is ProfileSuccess ||
//               current is ProfileError ||
//               current is ChangePictureImageError,
//           builder: (context, state) {
//             return state.maybeWhen(
//                 // profileLoading: () => Center(child: CircularProgressIndicator()),
//                 profileError: (error) {
//                   // Use addPostFrameCallback to ensure the widget tree has been built
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     setupErrorState(context, error);
//                   });
//                   return Center(
//                       child: Text('An error occurred')); // Return a widget
//                 },
//                 changePictureImageSuccess: () {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     TLoader.showSuccessSnackBar(
//                       context,
//                       title: 'Success',
//                       message: 'Profile image updated!',
//                     );

//                     // Reload profile to get the latest data
//                     context.read<ProfileCubit>().emitLoadingProfileData();
//                     // Emit new AvatarState to update other pages
//                     context.read<AvatarCubit>().loadProfileData();
//                     // user.value.profilePicture = imageURl;
//                   });

//                   return SizedBox
//                       .shrink(); // Return an empty widget as we're only triggering UI side effects
//                 },
//                 changePictureImageError: (error) {
//                   // Use addPostFrameCallback to ensure the widget tree has been built
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     setupErrorState(context, error);
//                   });
//                   return Center(child: Text('An error occurred'));
//                 },
//                 profileSuccess: (user) => Padding(
//                     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Stack(
//                             children: [
//                               // CircleAvatar with image
//                               BlocBuilder<ProfileCubit, ProfileState>(
//                                 builder: (context, state) {
//                                   return state.maybeWhen(
//                                     profileSuccess: (user) {
//                                       // Evict the cached image when the profile picture changes
//                                       if (user.profilePicture.isNotEmpty) {
//                                         CachedNetworkImageProvider(
//                                                 user.profilePicture)
//                                             .evict();
//                                       }

//                                       return CircleAvatar(
//                                         radius: 50,
//                                         backgroundImage:
//                                             user.profilePicture.isEmpty
//                                                 ? AssetImage(
//                                                     "assets/images/user.png")
//                                                 : CachedNetworkImageProvider(
//                                                     user.profilePicture),
//                                       );
//                                     },
//                                     orElse: () => Center(
//                                         child: CircularProgressIndicator()),
//                                   );
//                                 },
//                               ),

//                               // Positioned widget to place the edit icon at the bottom right
//                               Positioned(
//                                 bottom: 0,
//                                 right: 0,
//                                 child: InkWell(
//                                   onTap: () {
//                                     // Handle the image edit action here
//                                     context
//                                         .read<ProfileCubit>()
//                                         .uploadUserProfilePicture();
//                                   },
//                                   child: CircleAvatar(
//                                     radius: 18,
//                                     backgroundColor: ManagerColors.kCustomColor, // Background color for edit icon circle
//                                     child: Icon(
//                                       Icons.edit, // The edit icon
//                                       color: Colors.white, // Icon color
//                                       size: 20,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           myText(
//                             user.userName,
//                             fontSize: 16,
//                             color: ManagerColors.kCustomColor,
//                             fontWeight: FontWeightEnum.Bold.fontWeight,
//                           ),
//                           buildSpacerH(5.0),
//                           myText(AText.user.tr(context),
//                               fontSize: 16,
//                               fontWeight: FontWeightEnum.Bold.fontWeight,
//                               color: ManagerColors.yellowColor),
//                           buildSpacerH(10.0),
//                           Column(
//                             children: [
//                               buildAbleTextField(
//                                   text: user.userName,
//                                   validator: (value) =>
//                                       ManagerValidator.validateEmptyText(
//                                           "Name", "Izzdine Atallah")),
//                               buildSpacerH(10.0),
//                               buildAbleTextField(
//                                   text: user.email,
//                                   validator: (value) =>
//                                       ManagerValidator.validateEmail(
//                                           value, context)),
//                               buildSpacerH(10.0),
//                               buildAbleTextField(
//                                   text: user.phoneNumber,
//                                   validator: (value) =>
//                                       ManagerValidator.validateEmail(
//                                           value, context)),
//                               buildSpacerH(10.0),
//                               RoundedButtonWgt(
//                                   width: double.infinity,
//                                   fontSize: 16,
//                                   title: AText.save.tr(context),
//                                   onPressed: () {
//                                     //!! For Editing the Data For user ..........
//                                   })
//                             ],
//                           ),
//                         ])),
//                 orElse: () => Center(child: CircularProgressIndicator()));
//           },
//         )));
//   }

//   void setupErrorState(BuildContext context, String error) {
//     pop(context);
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         icon: const Icon(
//           Icons.error,
//           color: Colors.red,
//           size: 32,
//         ),
//         content: myText(error,
//             fontSize: 15,
//             fontWeight: FontWeight.bold,
//             color: ManagerColors.kCustomColor
//             // style: TextStyles.font15DarkBlueMedium,
//             ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               pop(context);
//             },
//             child: myText('Got it',
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: ManagerColors.yellowColor),
//           ),
//         ],
//       ),
//     );
//   }
// }
