import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_extended_image.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_app_bar_for_admin.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_offer_item.dart';
import 'package:acwadcom/models/offer_model.dart';

class ListOffersScreen extends StatefulWidget {
  const ListOffersScreen({super.key});

  @override
  State<ListOffersScreen> createState() => _ListOffersScreenState();
}

class _ListOffersScreenState extends State<ListOffersScreen> {
  final _db = FirebaseFirestore.instance;

  List<String> urls = [];

  // Function to fetch only the image URLs
  Future<List<OfferModel>> fetchOfferUrls()async{
    final ref =  await _db.collection('Offers').get();
    final offers = ref.docs.map((offer)=>OfferModel.fromSnapshot(offer)).toList();
    return offers;

        
  }

  Future<void> removeOffer(offerID)async{
    await _db.collection("Offers").doc(offerID).delete();
    TLoader.showSuccessSnackBar(context, title: AText.deleteOffer.tr(context));
  }
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: ManagerColors.kCustomColor,
        title: myText(
          AText.offfers.tr(context),
          color: ManagerColors.myWhite,
        ),
        leading: Padding(
          padding: EdgeInsets.only(
            left: Localizations.localeOf(context).languageCode == 'ar'
                ? 0
                : 16, // Padding for English
            right: Localizations.localeOf(context).languageCode == 'ar'
                ? 16
                : 0, // Padding for Arabic
          ),
          child: InkWell(
            onTap:  () {
              Navigator.pop(context);
            },
            child: svgImage("Vector", isRtl: isRTL(context)),
          ),
        ),
        leadingWidth: 50,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TSectionHeader(title: "Offers"),
            buildSpacerH(10.0),
            FutureBuilder<List<OfferModel>>(
                future: fetchOfferUrls(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No offer URLs available"));
                  }
                  final offers = snapshot.data!;
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => Stack(
                              children: [
                                BuildOfferItem(offer:offers[index]),
                                Positioned(
                                    top: 10,
                                    left: 15,
                                    child: InkWell(
                                      onTap: (){
                                          removeOffer(offers[index].id);
                                    // setState(() {});
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color:Colors.white,
                                        ),
                                        child: svgImage("_icRemove" )))
                                        
                                        ),
                              ],
                            ),

                        // SizedBox(
                        //   height: 100,
                        //   child: CachedNetworkImage(imageUrl: imageUrl![index] , fit: BoxFit.cover,)),
                        separatorBuilder: (context, index) => buildSpacerH(10),
                        itemCount:offers.length),
                  );
                })
          ],
        ),
      ),
    );
  }
}


