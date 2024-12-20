import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_shimmer_list_of_coupons.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

class BuildCustomPageWithPagination extends StatelessWidget {
  final int pageSize ; 
  final bool shrinkWrap;
  final Query query;
  final FirestoreItemBuilder itemBuilder;
  const BuildCustomPageWithPagination({
    super.key, required this.pageSize, required this.shrinkWrap, required this.query, required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return FirestoreListView.separated(
      
        loadingBuilder: (context) => buildShimmerListOfCoupons(),
        showFetchingIndicator: true,
        pageSize: pageSize,
        scrollDirection: Axis.vertical,
        fetchingIndicatorBuilder:(context) => Center(child: BuildCustomLoader()),
        shrinkWrap: shrinkWrap,
        query:query,
        itemBuilder:itemBuilder,
        separatorBuilder: (index, context) {
          return buildSpacerH(10);
        });
  }
}