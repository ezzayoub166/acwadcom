// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/no_internt_screen.dart';
import 'package:acwadcom/features/admin/ui/screens/add_offer_screen.dart';
import 'package:acwadcom/features/admin/ui/screens/home_screen_admi.dart';
import 'package:acwadcom/features/admin/ui/screens/request_screen_admin.dart';
import 'package:acwadcom/features/admin/ui/screens/stores_screen.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
class BottomTabBarAdmin extends StatefulWidget {
  const BottomTabBarAdmin({super.key});


  @override
  State<BottomTabBarAdmin> createState() => _BottomtabbarState();
}

class _BottomtabbarState extends State<BottomTabBarAdmin> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


    bool isConnectedToInternt = true;

   StreamSubscription? _intrenetConnectionStreamSubscription ; 

     @override
  void initState() {
    // TODO: implement initState
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
          isConnectedToInternt = false;
        });
      }
    });
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _intrenetConnectionStreamSubscription?.cancel();
  }

  var screens = [
    HomeScreenAdmin(),
    RequestScreenAdmin(),
    AddOfferScreen(),
    StoresForAdmin()

  ];

  @override
  Widget build(BuildContext context) {
    return isConnectedToInternt ?  Scaffold(
        // appBar: AppBar(
        //   title: Text('Navigation Bar with Shadow'),
        // ),
        body: Center(
          child:screens[_selectedIndex]
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          elevation: 10, // Shadow for the BottomAppBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               buildNavItem( "assets/images/_ichomefilled.svg", AText.home.tr(context), 0),
               buildNavItem("assets/images/_icTicket.svg", AText.requests.tr(context), 1),
               buildNavItem("assets/images/_icAddNewCoupon.svg", AText.requests.tr(context), 2),
                buildNavItem("assets/images/bag-svgrepo-com.svg", AText.stores.tr(context), 3),



              
             
              
             
            ],
          ),
        )) : NoNetWorkScreen();
  }

  Widget buildNavItem(String iconImg,String label, int index) {
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
