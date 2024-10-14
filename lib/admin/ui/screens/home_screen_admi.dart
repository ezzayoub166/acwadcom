import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/admin/ui/widgets/build_item_code_for_admin.dart';
import 'package:acwadcom/models/coupon_model.dart';

class HomeScreenAdmin extends StatelessWidget {


  const HomeScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
      List<Coupon> yourCoupons = [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ManagerColors.kCustomColor,
        title: myText(
           "All Coupons in App".tr(context),
            color: ManagerColors.myWhite,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: [
            myText("عدد الكوبونات : 33" , fontSize: 22 , color: ManagerColors.kCustomColor, fontWeight: FontWeight.bold),
            buildSpacerH(10.0),
            ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return BuildItmCodeForAdmin();
                },
                separatorBuilder: (ctx, index) => buildSpacerH(10.0),
                itemCount: 6)
          ],
        ),
      ),
    );
  }
}


