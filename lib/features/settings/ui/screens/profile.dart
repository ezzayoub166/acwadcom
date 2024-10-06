// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/authtication/data/authentication_repository.dart';
import 'package:acwadcom/features/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/settings/logic/cubit/profile_cubit.dart';
import 'package:acwadcom/features/settings/ui/widgets/build_disabled_textfiled.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';

class ProfileScreen extends StatefulWidget {
  final bool isEdit;
  const ProfileScreen({super.key, this.isEdit = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProfileCubit>(context).emitLoadingProfileData();
  }

  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      appBar: buildAppBarWithBackButton(context, isRtl),
      body: Center(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) => current is ProfileSuccess || current is ProfileError ,
          builder: (context, state) {
            return state.maybeWhen(
              profileSuccess: (user) => Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/tow.jpeg")),
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
                    Column(
                      children: [
                        buildDisabledTextField(text: user.userName
                            // validator: (value) =>
                            //     ManagerValidator.validateEmptyText(
                            //         "Name", "Izzdine Atallah"),

                            ),
                        buildSpacerH(10.0),
                        buildDisabledTextField(
                          text: user.email,
                        ),
                        buildSpacerH(10.0),
                        buildDisabledTextField(
                          text: user.phoneNumber,
                        ),
                        buildSpacerH(10.0),
                        RoundedButtonWgt(
                            title: AText.logOut.tr(context),
                            backgroundColor: ManagerColors.kCustomColor,
                            foregroundColor: Colors.white,
                            onPressed: () {
                              getIt<AuthenticationRepository>().logout(); 
                              navigateAndFinishNamed(context, Routes.chosenStatusScreen);
                            })
                      ],
                    )
                  ],
                ),
              ),
              profileError: (error) =>  setupError() ,
                  orElse : () => Center(child: CircularProgressIndicator(),)

            );
          },
        ),
      ),
    );
  }

  Widget setupError() {
    return const SizedBox.shrink();
  }
}
