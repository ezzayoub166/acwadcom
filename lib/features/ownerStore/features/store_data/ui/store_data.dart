// UserCubit.dart
import 'package:acwadcom/features/ownerStore/features/store_data/logic/store_data_cubit.dart';
import 'package:acwadcom/features/ownerStore/features/store_data/logic/store_data_state.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/user/settings/ui/widgets/build_abled_textfiled.dart';
import 'package:acwadcom/features/user/settings/ui/widgets/build_disabled_textfiled.dart';
import 'package:acwadcom/models/user_model.dart';
import '../../../../../../acwadcom_packges.dart';
import '../../../../../../common/widgets/build_custom_loader.dart';

class StoreDataScreen extends StatefulWidget {
  const StoreDataScreen({super.key});

  @override
  State<StoreDataScreen> createState() => _StoreDataScreenState();
}

class _StoreDataScreenState extends State<StoreDataScreen> {
  @override
  void initState() {
    super.initState();
    // context.read<StoreDataCubit>().fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithBackButton(context, isRTL(context)),
      body: BlocConsumer<StoreDataCubit, StoreDataState>(
          buildWhen: (previous, current) =>
              current is StoreDataLoading || current is StoreDataLoaded,
          builder: (context, state) {
            if (state is StoreDataLoading) {
              return Center(child: BuildCustomLoader());
            } else if (state is StoreDataLoaded) {
              context.read<StoreDataCubit>().userNameController.text =
                  state.user.userName;
              context.read<StoreDataCubit>().phoneNumberController.text =
                  state.user.phoneNumber;
              context.read<StoreDataCubit>().deatilsStoreController.text =
                  state.user.deatilsForStore ?? "";
              context.read<StoreDataCubit>().storeLinkController.text =
                  state.user.storeLink ?? "";
              return buildUserProfileForm(state.user);
            } else {
              return SizedBox.shrink();
            }
          },
          listenWhen: (previous, current) => current is StoreDataError,
          listener: (BuildContext context, state) {
            if (state is StoreDataError) {
              TLoader.showErrorSnackBar(context,
                  title: 'On Snap!', message: state.message.toString());
            }
          }),
    );
  }

  Widget buildUserProfileForm(UserModel user) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                BlocConsumer<StoreDataCubit, StoreDataState>(
                  buildWhen: (previous, current) =>
                      current is UserImageUploadSuccess ||
                      current is StoreDataImageUploading ||
                      current is StopLoadingImage,
                  builder: (context, state) {
                    if (state is StoreDataImageUploading) {
                      return CircleAvatar(
                        radius: 50,
                        child:
                            BuildCustomLoader(), // Show loader only during image uploading
                      );
                    } else if (state is UserImageUploadSuccess) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: CachedNetworkImageProvider(state.url),
                      );
                    } else {
                      // Show existing user profile picture or a placeholder image
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: user.profilePicture.isEmpty
                            ? AssetImage("assets/images/user.png")
                            : CachedNetworkImageProvider(user.profilePicture),
                      );
                    }
                  },
                  listenWhen: (previous, current) => current is StoreDataError,
                  listener: (BuildContext context, state) {
                    if (state is StoreDataError) {
                      TLoader.showErrorSnackBar(context,
                          title: 'On Snap!', message: state.message.toString());
                    }
                  },
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () => context
                        .read<StoreDataCubit>()
                        .uploadUserProfilePicture(),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: ManagerColors.kCustomColor,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            buildSpacerH(10.0),
            buildForm(user),
          ],
        ),
      ),
    );
  }

  Form buildForm(UserModel user) {
    return Form(
      key: context.read<StoreDataCubit>().formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //User Name
          buildAbleTextField(
            hintText: AText.username.tr(context),
            controller: context.read<StoreDataCubit>().userNameController,
            validator: (value) => ManagerValidator.validateEmptyText(
                AText.username.tr(context), value ?? ""),
          ),
          buildSpacerH(10.0),
          //Phone Number
          buildAbleTextField(
            hintText: AText.phoneNumber.tr(context),
            controller: context.read<StoreDataCubit>().phoneNumberController,
            validator: (value) =>
                ManagerValidator.validatePhoneNumber(value, context: context),
          ),
          buildSpacerH(10.0),
          buildDisabledTextField(
            text: user.email,
          ),
          buildSpacerH(10.0),
          buildAbleTextField(
              hintText: AText.deatilsStore.tr(context),
              controller: context.read<StoreDataCubit>().deatilsStoreController,
              validator: (value) => ManagerValidator.validateEmptyText(
                  AText.deatilsStore.tr(context), value ?? "")),
          buildSpacerH(10.0),
          buildAbleTextField(
              hintText: AText.linkofWebsite.tr(context),
              controller: context.read<StoreDataCubit>().storeLinkController,
              validator: (value) =>
                  ManagerValidator.validateURL(value, context)),
          buildSpacerH(10.0),
          RoundedButtonWgt(
            width: double.infinity,
            fontSize: 16,
            title: AText.save.tr(context),
            onPressed: () {
              if (context
                  .read<StoreDataCubit>()
                  .formKey
                  .currentState!
                  .validate()) {
                context.read<StoreDataCubit>().updateUserData(
                    context.read<StoreDataCubit>().userNameController.text,
                    context.read<StoreDataCubit>().phoneNumberController.text,
                    context.read<StoreDataCubit>().deatilsStoreController.text,
                    context.read<StoreDataCubit>().storeLinkController.text);
              }
            },
          )
        ],
      ),
    );
  }
}
