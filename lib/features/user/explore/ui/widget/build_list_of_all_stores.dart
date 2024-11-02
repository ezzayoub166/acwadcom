import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_store_card.dart';

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
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
            return buildStoreBigSiz(context, index, store);
                // child: Stack(
                //   alignment: Alignment.center,
                //   children: [
                //     Container(
                //      height: 100.h,
                //       // width: 130.w, 
                //       // width: double.infinity,
                //       padding: EdgeInsets.all(8.w),
                //       decoration: BoxDecoration(
                //         color: colorForITem,
                //         borderRadius: BorderRadius.circular(16.0),
                //       ),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           myText(store.userName,
                //               fontSize: 15,
                //               fontWeight:
                //               FontWeightEnum.Regular.fontWeight),
                //           myText(
                //             //TODO: MUST ADD DEATILS FILED FOR THIS POINT .....
                //             store.deatilsForStore??"أكواد خصم تصل إلى %20",
                //             fontSize: 16.0,
                //             color: Colors.grey[700],
                //             textAlign: TextAlign.center,
                //           ),
                //         ],
                //       ),
                //     ),
                //     Positioned(
                //       top: 10,
                //       left: 30.w,
                //       right: 30.w,
                //       child: CircleAvatar(
                //           radius: 30,
                //           backgroundColor: ManagerColors.kCustomColor,
                //           backgroundImage: CachedNetworkImageProvider(
                //               store.profilePicture),
                //           onBackgroundImageError:
                //               (error, stackTrace) {
                //             print("Error loading image: $error");
                //           }),
                //     ),
                //   ],
                // ));
          }),
    );
  }

  Widget buildStoreBigSiz(BuildContext context, int index, UserModel store) {
    return InkWell(
              onTap: () {
                // navigateNamedTo(context, Routes.storeDeatilsScreen,
                //     stores[index]);
                navigateTo(context,StoreDeatilsScreen(store: stores[index]));
    
              },
              child: Container(
          // width: double.infinity,
          // padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.grey , width: 0.5)
          ),
          child: Column(
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius as needed
                  ),
                  clipBehavior: Clip.antiAlias,
                  elevation: 5.0,
                  child: CachedNetworkImage(imageUrl: store.profilePicture,height: 100,fit: BoxFit.contain,)),
              Expanded(
                child: Column(
                  children: [
                    myText(store.userName , fontSize: 15 , fontWeight: FontWeightEnum.SemiBold.fontWeight),
                    buildSpacerH(5.0),
                    myText(
                  //!!! TODO create the deatis for store owner ,,,,, when create account
                  store.deatilsForStore??"أكواد خصم تصل إلى %",
                    fontSize: 12.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    
                    color: Colors.grey[700],
                  textAlign: TextAlign.center,
                ),
                  ],
                ),
              ),
              
          ]
    )));
  }
}
