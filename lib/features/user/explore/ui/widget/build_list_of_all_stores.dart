import '../../../../../acwadcom_packges.dart';
import '../../../../../models/user_model.dart';
import '../../../store/ui/screens/store_deatils_screen.dart';

class BuildlistOfAllStores extends StatelessWidget {
  final List<UserModel> stores;
  final  Color? colorForITem;
  const BuildlistOfAllStores({
    super.key, required this.stores, this.colorForITem =Colors.white ,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
                // navigateNamedTo(context, Routes.storeDeatilsScreen,
                //     stores[index]);
                navigateTo(context,StoreDeatilsScreen(store: stores[index]));

              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                   height: 100.h,
                    // width: 130.w, 
                    // width: double.infinity,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: colorForITem,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        myText(store.userName,
                            fontSize: 15,
                            fontWeight:
                            FontWeightEnum.Regular.fontWeight),
                        myText(
                          //TODO: MUST ADD DEATILS FILED FOR THIS POINT .....
                          store.deatilsForStore??"أكواد خصم تصل إلى %20",
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
                        backgroundImage: CachedNetworkImageProvider(
                            store.profilePicture),
                        onBackgroundImageError:
                            (error, stackTrace) {
                          print("Error loading image: $error");
                        }),
                  ),
                ],
              ));
        });
  }
}
