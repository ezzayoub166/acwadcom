// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/explore/data/store_model.dart';
import 'package:acwadcom/features/explore/ui/widget/build_list_featured_stores.dart';

class ExplpreScreen extends StatefulWidget {
  const ExplpreScreen({super.key});

  @override
  State<ExplpreScreen> createState() => _ExplpreScreenState();
}

class _ExplpreScreenState extends State<ExplpreScreen> {

 
  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width * 0.8;

     final List<StoreModel> stores = [
    StoreModel(name: "فيد بيكس", imageUrl: "https://logodix.com/logo/2310.png", deatilsForCopunns: "أكواد خصم تصل الى %20"),
    StoreModel(name: "Smile Shop", imageUrl: "https://img.freepik.com/free-vector/gradient-instagram-shop-logo-template_23-2149704603.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727308800&semt=ais_hybrid", deatilsForCopunns: "أكواد خصم تصل الى %20"),
    StoreModel(name: "ابل", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHuSKg3KQINvWnpNkd9brsgcZmMyjYIeuNjQ&s", deatilsForCopunns: "أكواد خصم تصل الى %20"),
    StoreModel(name: "لوكي", 
    imageUrl: "https://www.robotbutt.com/wp-content/uploads/2016/02/goodwill-logo.jpg", 
    deatilsForCopunns: "أكواد خصم تصل الى %20"),
  ];

    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: TSizes.defaultSpace,
              vertical: TSizes.defaultSpace,
            ),
            child: ListView(children: [
              customAppBar(context),
              buildSpacerH(10.0),
              ASearchContainer(text: AText.search.tr(context)),
              buildSpacerH(10.0),
              TSectionHeader(
                title: AText.mostUsedCopuns.tr(context),
                textColor: ManagerColors.kCustomColor,
              ),
              buildSpacerH(5.0),
              //** The most used Copuns  */
              BuildListMostUserCopuns(itemWidth: itemWidth),
              //** The Special Stores */
              buildSpacerH(10.0),
               TSectionHeader(
                title: AText.featuredStore.tr(context),
                textColor: ManagerColors.kCustomColor,
              ),
              buildSpacerH(5.0),
              BuildListFeaturedStores(stores: stores,),

              buildSpacerH(10.0),
              //** The Adddred Recntly */
              TSectionHeader(
                title: AText.recntlyAdded.tr(context),
                textColor: ManagerColors.kCustomColor,
              ),
              buildSpacerH(5.0),
              BuildListMostUserCopuns(itemWidth: itemWidth),


              
              

            ])));
  }
}
