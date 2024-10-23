
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_store_card.dart';
import 'package:acwadcom/features/user/store/ui/screens/store_deatils_screen.dart';
import 'package:acwadcom/models/user_model.dart';

class BuildListFeaturedStores extends StatelessWidget {
    const BuildListFeaturedStores({
    super.key,
    required this.stores,
  });

  final  List<UserModel> stores ;

  

  @override
  Widget build(BuildContext context) {

    
    return LayoutBuilder(
           builder: (BuildContext context, BoxConstraints constraints) {
          // Check the available width and height in constraints
          double availableWidth = constraints.maxWidth;
          double availableHeight = constraints.maxHeight; 
          // print(availableHeight.);
          if(availableHeight > 600){
   return SizedBox(
         height: 150,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: stores.length,
          separatorBuilder: (ctx, index) => buildSpacerW(10.0),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                navigateTo(context,StoreDeatilsScreen(store: stores[index]));
              },
              child: StoreCard(store: stores[index],));
          },
      )
          );
          }else{
               return SizedBox(
         height: 160,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: stores.length,
          separatorBuilder: (ctx, index) => buildSpacerW(10.0),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                // navigateNamedTo(context, Routes.storeDeatilsScreen , stores[index]);
                navigateTo(context,StoreDeatilsScreen(store: stores[index]));

              },
              child: StoreCard(store: stores[index],));
          },
      )
          );
          }
       
           });
  }
}


