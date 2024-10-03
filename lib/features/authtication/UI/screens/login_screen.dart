import 'package:acwadcom/acwadcom_packges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.tYPEUSER});

  final String tYPEUSER;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // addTestData();
  }


  void addTestData() async {
  try {
    
    await FirebaseFirestore.instance.collection("test").add({
      "Name": "IOS TEST DONE"
    });
    print("Document added successfully!");
  } catch (e) {
    print("Error adding document: $e");
  }
}




  Widget buildRegisterNewAccount(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, //For horizantol
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: myText(
            AText.nohaveAccount.tr(context),
            textAlign: TextAlign.center,
            fontSize: 14.sp,
            color: Colors.white,
            overflow: TextOverflow.ellipsis, // Avoid overflow
          ),
        ),
        // SizedBox(width: 1), // Add some spacing between the two widgets
        TextButton(
          onPressed: () {
            //TODO: Go to the chosen user or Shop owner
            if (widget.tYPEUSER == "User") {
              navigateNamedTo(context, Routes.signUpScreen,widget.tYPEUSER);
            } else {
              navigateNamedTo(context, Routes.registerOwnerStore,widget.tYPEUSER);
            }
          },
          child: myText(
            AText.regiserNewAccount.tr(context),
            color: ManagerColors.yellowColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget buildForgetPassButton(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        AText.forgetPass.tr(context),
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: ManagerColors.yellowColor),
      ),
    );
  }

  Widget buildBlocWidget(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      GlobalKey<FormState> formKey) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 30),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // buildSpacer(10.0),
                Text(
                  AText.loginlbl.tr(context),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Colors.white),
                ),
                buildSpacerH(20.0),
                RoundedInputField(
                  controller: emailController,
                  hintText: AText.email.tr(context),
                  validator: (value) {
                    return ManagerValidator.validateEmail(value, context);
                  },
                ),
                buildSpacerH(20.0),
                RoundedInputField(
                  controller: passwordController,
                  hintText: AText.yourPassword.tr(context),
                  isSecure: true,
                  validator: (value) {
                    return ManagerValidator.validatePassword(value, context);
                  },
                ),
                buildSpacerH(11.0),
                buildForgetPassButton(context),
                RoundedButtonWgt(
                    title: AText.loginlbl.tr(context),
                    fontSize: 18,
                    onPressed: () {
                      //TODO:  make it Login Function ....
                      if (widget.tYPEUSER == "User") {
                        if (formKey.currentState!.validate()) {
                          if ((emailController.text ==
                                  "adminOwner1000@gmail.com") &&
                              (passwordController.text ==
                                  "adminOwner1000@gmail.com")) {
                            navigateAndFinishNamed(context, Routes.tabBarAdmin);
                          } else {
                            navigateAndFinishNamed(
                                context, Routes.bottomTabBarScreen);
                          }
                        }
                      } else {
                        navigateAndFinishNamed(
                            context, Routes.homeScreenForOwenerStore);
                      }
                    }),
                buildRegisterNewAccount(
                  context,
                ),
                buildSpacerH(20.0),
                const DividerWithText(),
                buildSpacerH(20.0),
                buildListOfLoginButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///MARK: Scaffold
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    emailController.text = "adminOwner1000@gmail.com";
    passwordController.text = "adminOwner1000@gmail.com";


  

    GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: ManagerColors.kCustomColor,
        appBar: AppBar(
          backgroundColor: ManagerColors.kCustomColor,
          elevation: 0, // Make the AppBar blend with the background
          automaticallyImplyLeading: false, // Remove the default back button
          actions: [
            TextButton(
              onPressed: () {
                // TODO: Add your "Skip" button logic here
                // For example: navigate to the home screen
                navigateAndFinishNamed(context, Routes.bottomTabBarScreen);
              },
              child: myText(AText.skip.tr(context),
                  color: ManagerColors.yellowColor, fontSize: 16),
            ),
          ],
        ),
        body: buildBlocWidget(
            context, emailController, passwordController, loginFormKey));
  }
}
