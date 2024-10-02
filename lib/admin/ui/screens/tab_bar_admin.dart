// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/admin/ui/screens/home_screen_admi.dart';
import 'package:acwadcom/admin/ui/screens/request_screen_admin.dart';
class BottomtabbarAdmin extends StatefulWidget {
  const BottomtabbarAdmin({super.key});


  @override
  State<BottomtabbarAdmin> createState() => _BottomtabbarState();
}

class _BottomtabbarState extends State<BottomtabbarAdmin> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var screens = [
    HomeScreenAdmi(),
    RequestScreenAdmin()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Navigation Bar with Shadow'),
        // ),
        body: Center(
          child:screens[_selectedIndex]
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          elevation: 5, // Shadow for the BottomAppBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               buildNavItem( "assets/images/_ichomefilled.svg", AText.home.tr(context), 0),
               buildNavItem("assets/images/_icTicket.svg", AText.requests.tr(context), 1),
              
             
              
             
            ],
          ),
        ));
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
