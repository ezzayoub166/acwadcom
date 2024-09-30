
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/explore/data/store_model.dart';
import 'package:acwadcom/features/explore/ui/widget/build_store_card.dart';

class BuildListFeaturedStores extends StatelessWidget {
    const BuildListFeaturedStores({
    super.key,
    required this.stores,
  });

  final  List<StoreModel> stores ;

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
       height: 170.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: stores.length,
        separatorBuilder: (ctx, index) => buildSpacerW(10.0),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              navigateNamedTo(context, Routes.storeDeatilsScreen , stores[index]);
            },
            child: StoreCard(store: stores[index],));
        },
      ),
    );
  }
}


