
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_alert_deatils_for_store.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_item_code_for_admin.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_shimmer_list_of_coupons.dart';
import 'package:acwadcom/features/user/coupons/ui/screens/coupon_deatls_screen.dart';
import 'package:acwadcom/models/coupon_model.dart';

class PaginatedCouponList extends StatefulWidget {
  @override
  _PaginatedCouponListState createState() => _PaginatedCouponListState();
}

class _PaginatedCouponListState extends State<PaginatedCouponList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final int pageSize = 6;
  bool isLoading = false;
  bool hasMoreData = true;
  DocumentSnapshot? lastDocument;
  List<Coupon> coupons = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener); // Add the scroll listener
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  // Scroll listener to detect when we reach the bottom
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // When bottom is reached, load more data
      if (!isLoading && hasMoreData) {
        _loadMoreCoupons();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _getCouponsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildShimmerListOfCoupons();
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final docs = snapshot.data?.docs ?? [];
          final List<Coupon> fetchedCoupons = docs.map((doc) {
            return Coupon.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();

          // Add new data to the existing coupons
          coupons.addAll(fetchedCoupons);

          // Update the last document
          if (docs.isNotEmpty) {
            lastDocument = docs.last;
          }

          // Check if there is more data to load
          hasMoreData = docs.length == pageSize;

          return ListView.builder(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            itemCount: coupons.length +
                (hasMoreData ? 1 : 0), // Add one more for the loading indicator
            itemBuilder: (context, index) {
              if (index == coupons.length) {
                // Show loading indicator at the bottom when more data is being fetched
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final coupon = coupons[index];
              return GestureDetector(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return buildAlertDeatilsForStore(context, coupon);
                      });
                },
                onTap: () {
                  navigateTo(
                      context,
                      CouponDeatlsScreen(
                        coupon: coupon,
                      ));
                },
                child: BuildItmCodeForAdmin(
                  coupon: coupon,
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Create a stream that listens to new coupon data
  Stream<QuerySnapshot> _getCouponsStream() {
    Query query = _firestore.collection('Coupons').limit(pageSize);

    // Start from where the last query ended (if applicable)
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    return query.snapshots();
  }

  // Load more coupons when scrolled to the bottom
  void _loadMoreCoupons() {
    setState(() {
      isLoading = true;
    });

    // Simulate a delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }
}
