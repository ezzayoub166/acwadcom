// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/no_internt_screen.dart';
import 'package:acwadcom/features/user/explore/ui/screens/explpre_screen.dart';
import 'package:acwadcom/features/user/home/logic/avatar/avatar_cubit.dart';
import 'package:acwadcom/features/user/home/ui/home_screen.dart';
import 'package:acwadcom/features/user/home/ui/widgets/show_required_dialog.dart';
import 'package:acwadcom/features/user/settings/ui/screens/settings.dart';
import 'package:acwadcom/features/user/wishlist/ui/wishlist_screen.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class Bottomtabbar extends StatefulWidget {
  const Bottomtabbar({super.key});

  @override
  State<Bottomtabbar> createState() => _BottomtabbarState();
}

class _BottomtabbarState extends State<Bottomtabbar> {
  int _selectedIndex = 0;

   bool isConnectedToInternt = true;

   StreamSubscription? _intrenetConnectionStreamSubscription ; 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var screens = [
    HomeScreen(),
    ExplpreScreen(),
    WishlistScreen(),
    SettingsScreen()
  ];

  @override
  void initState() {
        _intrenetConnectionStreamSubscription = InternetConnection().onStatusChange.listen((event){
      switch (event){
        case InternetStatus.connected:
        setState(() {
          isConnectedToInternt =  true;
        });
        break;
        case InternetStatus.disconnected:
        setState(() {
          isConnectedToInternt = false ;
        });
        break;
        default:
        setState(() {
          isConnectedToInternt = false;});
      }
    });
    super.initState();
        BlocProvider.of<AvatarCubit>(context).loadProfileData();


        // BlocProvider.of<ProfileCubit>(context).emitLoadingProfileData();


  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _intrenetConnectionStreamSubscription?.cancel();
  }



  

  @override
  Widget build(BuildContext context) {
    return isConnectedToInternt ?  Scaffold(
        // appBar: AppBar(
        //   title: Text('Navigation Bar with Shadow'),
        // ),
        body: Center(child: screens[_selectedIndex]),
        floatingActionButton: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              // Add your action here
              // navigateNamedTo(context, Routes.createCodeForUserScreen);
              if (isLoggedInUser) {
                navigateNamedTo(context, Routes.createCodeForUserScreen);
              } else {
                showRequireLoginDialog(context);
              }
            },
            backgroundColor: ManagerColors.yellowColor,
            child: const Icon(Icons.add) // Match your theme color
            // shape: RoundedRectangleBorder( // Custom shape if needed
            //   borderRadius: BorderRadius.circular(20), // Adjust for more square shape
            // ),
            ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          elevation: 5, // Shadow for the BottomAppBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildNavItem(
                  "assets/images/_ichomefilled.svg", AText.home.tr(context), 0),
              buildNavItem("assets/images/_icDiscover.svg",
                  AText.explore.tr(context), 1),
              buildSpacerW(48),
              buildNavItem("assets/images/_icFavorites.svg",
                  AText.wishlist.tr(context), 2),
              buildNavItem(
                  "assets/images/_icprofile.svg", AText.profile.tr(context), 3),
            ],
          ),
        )) : NoNetWorkScreen();
  }

  Widget buildNavItem(String iconImg, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          svgIconFilterdColor(iconImg, index),
          buildSpacerH(2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == index ? Colors.orange : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  SvgPicture svgIconFilterdColor(String iconImg, int index) {
    return SvgPicture.asset(
      iconImg,
      height: 24,
      width: 24,
      colorFilter: ColorFilter.mode(
          _selectedIndex == index
              ? ManagerColors.yellowColor
              : ManagerColors.kCustomColor,
          BlendMode.srcIn),
    );
  }
}
