// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/coupons/ui/screens/coupon_deatls_screen.dart';
import 'package:acwadcom/features/home/ui/widgets/build_featured_code.dart';
import 'package:acwadcom/ownerStore/features/home/no_coupon_screen.dart';
import 'package:acwadcom/ownerStore/features/home/widgets/custom_drawer.dart';
import 'package:acwadcom/ownerStore/features/home/widgets/custom_pop_dialog_delete.dart';

class HomeScreenOwner extends StatefulWidget {

  

  const HomeScreenOwner({super.key});

  @override
  State<HomeScreenOwner> createState() => _HomeScreenOwnerState();
}

class _HomeScreenOwnerState extends State<HomeScreenOwner> {

List<String> items = [""];

// Function to show the dialog
void showConfirmDeleteDialog(BuildContext context, String codeName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmDeleteDialog(codeName: codeName);
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20.0 , vertical: 20.0),
      child: ListView(
        children: [
          items.isEmpty ? NoCouponsScreen() : Column(
              children:  [
                TSectionHeader(title: "Your coupons".tr(context),textColor: ManagerColors.textColor,),
                 buildSpacerH(TSizes.spaceBtwItems),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx , index){
                  return InkWell(
                    onTap: (){
                      navigateNamedTo(context, Routes.storeOwnerDiscountCodeDetails);
                    },
                    child: BuildFeaturedCode(isShowRemove: true,));
                }, 
                separatorBuilder: (ctx , index ) => buildSpacerH(10.0), itemCount: 6)
              ],
            )
        
        ],
      ),
      ),
      drawer:CustomDrawer()
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title:           myText("Nike Store" , ),

      actions: [
        SizedBox(width: 20,),
        CircleAvatar(
          radius: 15,
          backgroundColor: ManagerColors.myWhite,
          backgroundImage: CachedNetworkImageProvider("https://logodix.com/logo/2310.png",),
          
          ),
                  SizedBox(width: 20,),

        ]
    );
  }
}
