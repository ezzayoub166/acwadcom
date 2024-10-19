// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/explore/data/store_model.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_list_featured_stores.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';


class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  //** the data for WishList  **/
  final List<StoreModel> favStores = [];
  final List<String> favCoupns = [];



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, 
          vertical: isLoggedInUser ? TSizes.defaultSpace : 5,
        ),
        child: ListView(
          children: [
            isLoggedInUser ? customAppBar(context) : SizedBox(height: 1,),
            buildSpacerH(10.0),
            ASearchContainer(text: AText.search.tr(context)),
            buildSpacerH(20.0),
            Container(
              height: 45.h,
              // margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the entire tab bar
                // borderRadius: BorderRadius.circular(
                //   25.0,
                // ),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                controller: _tabController,

                indicator: BoxDecoration(
                  color: Color(0xffF1F1F1),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                labelColor: ManagerColors.kCustomColor,
                unselectedLabelColor: ManagerColors.kCustomColor,
                
              
                tabs: [
                  TabItem(title: "Copuns", count: 1),
                  TabItem(title: "Stores", count: 4)
                ],
              ),
            ),
            buildSpacerH(20.0),
            SizedBox(
              height: 400.h,
              child: TabBarView(
                controller: _tabController,
                children: [
                  favCoupns.isEmpty ? emptyWishList(context) : BuildListMostUserCopuns(itemWidth: MediaQuery.of(context).size.width * 0.8),

                  favStores.isEmpty ? emptyWishList(context) :BuildListFeaturedStores(stores: favStores)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class WishListCopuns extends StatefulWidget {

    final List<String> favCoupns = [];

   WishListCopuns({super.key});

  @override
  State<WishListCopuns> createState() => _WishListCopunsState();


}

class _WishListCopunsState extends State<WishListCopuns> {
  @override
  Widget build(BuildContext context) {
    return emptyWishList(context)    ;
  }
}

class TabItem extends StatelessWidget {
  final String title;
  final int count;

  const TabItem({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          myText(
            title,
            overflow: TextOverflow.ellipsis,
          ),
       Container(
                  margin: const EdgeInsetsDirectional.only(start: 5),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: ManagerColors.kCustomColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      count > 9 ? "9+" : count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

Widget emptyWishList(BuildContext context){
  return Padding(
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: svgImage("heart")),
        buildSpacerH(5.0),
        myText(AText.emptyWishList , 
        textAlign: TextAlign.center,
        fontSize: 20,
        fontWeight: FontWeightEnum.Bold.fontWeight,
        maxLines: 2,
        ),
        buildSpacerH(5.0),
        myText(
          AText.followTohaveWishList , 
          textAlign: TextAlign.center,
        color: ManagerColors.lighTextForWishList,
        fontWeight: FontWeightEnum.Regular.fontWeight,
        fontSize: 14
        ),
        buildSpacerH(10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: RoundedButtonWgt(
            height: 50,
            backgroundColor: ManagerColors.kCustomColor,
            title: AText.browsetheStores.tr(context), onPressed: (){}),
        )
    
    
      ],
    ),
  );
}
