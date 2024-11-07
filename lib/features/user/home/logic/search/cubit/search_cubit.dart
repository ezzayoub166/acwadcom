import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

class SearchCubit extends Cubit<SearchState> {
  // final List<Coupon> items;

  final _db = FirebaseFirestore.instance;

  final searchController = TextEditingController();

  SearchCubit() : super(const SearchState.initial());

  // Search function to filter items based on the search query
  void search() async{
    if (searchController.text.isEmpty) {
      emit(const SearchState.initial());
    } else {
      emit(const SearchState.loading());

      try {
        // Filter the list based on the query

        var snapshot = await  _db
            .collection("Coupons")
            .where('Title', isGreaterThanOrEqualTo: searchController.text)
            .where('Title', isLessThanOrEqualTo: searchController.text + '\uf8ff')
            .get();

         final coupons = snapshot.docs.map((document) => Coupon.fromSnapshot(document)).toList();

        // List<String> filteredItems = items
        //     .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        //     .toList();

        // Emit the filtered results
        emit(SearchState.loaded(coupons));
      } catch (e) {
        emit(SearchState.error(e.toString()));
      }
    }
  }
}
