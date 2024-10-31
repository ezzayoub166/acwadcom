import 'package:cloud_firestore/cloud_firestore.dart';

class OfferModel{
  final String id ; 
  final String imageUrl ; 
  final String offerUrl;

  OfferModel({required this.id, required this.imageUrl, required this.offerUrl});

  Map<String , dynamic> toJson(){
    return {
      "Id":id,
      "ImageUrl":imageUrl,
      "OfferUrl":offerUrl
    };
  }

  factory OfferModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    if(document.data() !=null){
      final data = document.data()!;
      return OfferModel(id: data["Id"], imageUrl: data["ImageUrl"], offerUrl: data["OfferUrl"]);

    }else{
      return OfferModel.empty();
    }
  }

  factory OfferModel.empty(){
    return OfferModel(id: "", imageUrl: "", offerUrl: "");
  }
}