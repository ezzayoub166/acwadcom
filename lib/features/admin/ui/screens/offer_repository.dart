import 'package:acwadcom/acwadcom_packges.dart';

class OfferRepository{
  final _db = FirebaseFirestore.instance;

  //* fetch offers ..
  // Future<List<String>> fetchOffersImages()async{
  //   final ref = await _db.collection("Offers").get();
  //   final list =  ref.docs.map((offer) => offer.data().entries);
  // return list

  
  // }

    // Function to fetch offers
  Stream<List<Map<String, dynamic>>> fetchOffers() {
    return _db.collection('Offers').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
}