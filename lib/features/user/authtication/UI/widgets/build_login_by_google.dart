
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';

class buildLoginByGoogle extends StatelessWidget {
  const buildLoginByGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedButtonWgt(
      backgroundColor: ManagerColors.myWhite,
      foregroundColor: Colors.black,
      title: "",
      onPressed: () async {
        showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.all(24),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon at the top
                    SizedBox(
                      width: 100,
                      height: 100,
                      child:
                          svgImage("icBuildLogo", fit: BoxFit.fill),
                    ),
                    SizedBox(height: 16),
    
                    // Confirmation Text
                    Column(
                      children: [
                        myText(
                          "sign in as ?",
                              // .tr(context),
                          textAlign: TextAlign.center,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
    
                    // Buttons: Cancel and Delete
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ManagerColors.yellowColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () async{
                              //sign in as user action here ...
                              tYPEUSER = "USER";
                              print(tYPEUSER);
                              context.pop();
                               await context.read<LoginCubit>().emitLogInByGoogle(context);
    
    
                            },
                            child: Text(AText.user
                                .tr(context)), //loclaiztion
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12),
                              side: BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () async{
                              // Handle sing as store action here..
                                tYPEUSER = "STOREOWNER";
                                context.pop();
                                print(tYPEUSER);
                               await context.read<LoginCubit>().emitLogInByGoogle(context);
                         
                            },
                            child: myText(
                                AText.shopOwner.tr(context),
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            });
       
      },
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AText.loginByGoogle.tr(context),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
          ),
          SizedBox(
            width: 8.w,
          ),
          svgImage("google_brand_branding_logo_network_icon",
              height: 24.h, width: 24.w),
        ],
      ),
    );
  }
}
