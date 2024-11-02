// ignore_for_file: avoid_print

import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/explore/logic/cubit/explore_cubit.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';

import '../../../../../acwadcom_packges.dart';
import '../../../../../models/user_model.dart';

class StoresForAdmin extends StatefulWidget {
  // final List<UserModel> stores;
  // final  Color? colorForITem;
  const StoresForAdmin({
    super.key,
  });

  @override
  State<StoresForAdmin> createState() => _StoresForAdminState();
}
class _StoresForAdminState extends State<StoresForAdmin> {
  List<bool> isFeaturedList = []; // List to keep track of the isFeatured status

  @override
  void initState() {
    super.initState();
    // Initialize the list when the widget is created
    // Note: This assumes you know the number of stores in advance
    // You may need to adjust this if you get the stores dynamically
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExploreCubit>()..fetchStores(),
      child: BlocBuilder<ExploreCubit, ExploreState>(
        buildWhen: (previous, current) => current is LoadingStores || current is SucessGetStores || current is FaluireGetStores,
        builder: (context, state) {
          return state.maybeWhen(
            loadingStores: () => BuildCustomLoader(),
            sucessGetStores: (stores) {
              // Initialize the isFeaturedList based on the stores data
              if (isFeaturedList.isEmpty) {
                isFeaturedList = stores.map((store) => store.isFeaturedStore ?? false).toList();
              }

              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.builder(
                  itemCount: stores.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10, // spacing between rows
                    crossAxisSpacing: 20, // spacing between columns
                  ),
                  itemBuilder: (context, index) {
                    var store = stores[index];
                    return buildStoreBigSize(context, index, store, isFeaturedList[index]);
                  },
                ),
              );
            },
            orElse: () {
              return const SizedBox();
            },
          );
        },
      ),
    );
  }

  Widget buildStoreBigSize(BuildContext context, int index, UserModel store, bool isFeatured) {
    final _db = FirebaseFirestore.instance;

    // Function to toggle the "isFeaturedStore" status
    Future<void> toggleFeaturedStatus(bool isFeatured) async {
      try {
        await _db
            .collection('Users') // Adjust this to your collection path
            .doc(store.id) // Use the correct document ID
            .update({'isFeaturedStore': isFeatured});
      } catch (e) {
        print('Error updating isFeaturedStore: $e');
      }
    }

    // Function to delete the store from Firestore
    Future<void> deleteStore() async {
      try {
        await _db
            .collection('Users') // Adjust this to your collection path
            .doc(store.id) // Use the correct document ID
            .delete();
      } catch (e) {
        print('Error deleting store: $e');
      }
    }

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
              ),
              clipBehavior: Clip.antiAlias,
              elevation: 5.0,
              child: CachedNetworkImage(
                imageUrl: store.profilePicture,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                myText(
                  store.userName,
                  fontSize: 15,
                  fontWeight: FontWeightEnum.SemiBold.fontWeight,
                ),
                buildSpacerH(5.0),
                myText(
                  store.deatilsForStore ?? "أكواد خصم تصل إلى %",
                  fontSize: 12.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.grey[700],
                  textAlign: TextAlign.center,
                ),
                buildSpacerH(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isFeatured,
                          onChanged: (bool? value) {
                            if (value != null) {
                              setState(() {
                                isFeaturedList[index] = value;
                              });
                              toggleFeaturedStatus(value);
                            }
                          },
                        ),
                        Text('Featured'),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: ManagerColors.kCustomColor,
                              title: const Text('Delete Store'),
                              content: const Text('Are you sure you want to delete this store?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteStore();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
