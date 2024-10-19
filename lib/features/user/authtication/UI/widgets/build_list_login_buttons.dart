

import 'package:acwadcom/acwadcom_packges.dart';

Widget buildListOfLoginButtons(BuildContext context){
    return Column(
                  children: [
                    ///Login By Google
                    RoundedButtonWgt(
                      backgroundColor: ManagerColors.myWhite,
                      foregroundColor: Colors.black,
                      title: "",
                      onPressed: () {},
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
                          SizedBox(width: 8.w,),
                          svgImage("google_brand_branding_logo_network_icon",height: 24.h,width:24.w ),
                            // SvgPicture.asset(
                            //   "assets/images/google_brand_branding_logo_network_icon.svg"),
                        ],
                      ),
                    ),
                    buildSpacerH(15.0),
                    ///Lgon By Facebook
                    RoundedButtonWgt(
                      backgroundColor: ManagerColors.myWhite,
                      foregroundColor: Colors.black,
                      title: "",
                      onPressed: () {},
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AText.loginByFacebook.tr(context),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
                           SizedBox(width: 8.w,),
                          svgImage("facebook_logo_icon",height: 24.h,width:24.w ),                         
                        ],
                      ),
                    ),
                   buildSpacerH(15.0),
                   //Login by Apple
                    RoundedButtonWgt(
                      backgroundColor: ManagerColors.myWhite,
                      foregroundColor: Colors.black,
                      title: "",
                      onPressed: () {},
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AText.loginByApple.tr(context),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
                          buildSpacerW(8),
                          svgImage("104447_apple_logo_icon",height: 30.h,width:30.w),
                         
                        ],
                      ),
                    ),
                  
                  ],
                );
  }