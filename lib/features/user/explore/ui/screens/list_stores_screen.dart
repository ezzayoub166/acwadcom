import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/user/explore/data/store_model.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_list_featured_stores.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_store_card.dart';

class ListStoresScreen extends StatelessWidget {
  final List<StoreModel> stores;

  const ListStoresScreen({super.key, required this.stores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: buildAppBarWithBackButton(context, isRTL(context),
            title: AText.stores.tr(context)),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: GridView.builder(
              itemCount: stores.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                mainAxisSpacing: 10, // spacing between rows
                crossAxisSpacing: 20, // spacing between columns
              ),
              itemBuilder: (context, index) {
                var store = stores[index];
                return InkWell(
                    onTap: () {
                      navigateNamedTo(
                          context, Routes.storeDeatilsScreen, stores[index]);
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 150,
                          // width: 130, // Fixed responsive width
                          // width: double.infinity,
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              myText(store.name,
                                  fontSize: 15,
                                  fontWeight:
                                      FontWeightEnum.Regular.fontWeight),
                              myText(
                                store.deatilsForCopunns,
                                fontSize: 16.0,
                                color: Colors.grey[700],
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 30.w,
                          right: 30.w,
                          child: CircleAvatar(
                              radius: 30,
                              backgroundColor: ManagerColors.kCustomColor,
                              backgroundImage:
                                  CachedNetworkImageProvider(store.imageUrl),
                              onBackgroundImageError: (error, stackTrace) {
                                print("Error loading image: $error");
                              }),
                        ),
                      ],
                    ));
              }),
        ));
  }
}
