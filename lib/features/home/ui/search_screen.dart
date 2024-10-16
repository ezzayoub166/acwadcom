import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_spacer_height.dart';
import 'package:acwadcom/features/coupons/ui/screens/coupon_deatls_screen.dart';
import 'package:acwadcom/features/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/home/logic/search/cubit/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: buildAppBarWithBackButton(
          context,
          title:"Start typing to search...".tr(context),
          isRTL(context),

          // // backgroundColor: ManagerColors.kCustomColor,
          // title: myText("Search Coupns.",
          //     color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: context.read<SearchCubit>().searchController,
                keyboardType: TextInputType.text,
                style:
                    TextStyle(color: ManagerColors.kCustomColor, fontSize: 16),
                onChanged: (value) {
                  context.read<SearchCubit>().search();
                },
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "must Fill the text".tr(context);
                    } else {
                      return null;
                    }
                  }
                },
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: ManagerColors.kCustomColor, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: ManagerColors.kCustomColor, width: 1)),
                  labelText: AText.search.tr(context),
                  suffix: Icon(Icons.search, color: ManagerColors.kCustomColor),
                  border: InputBorder.none,
                ),
              ),

              // TextField(

              //   decoration: InputDecoration(

              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: const BorderSide(color: ManagerColors.kCustomColor , width: 1)
              //     ),
              //   ),
              //   onChanged: (query) {
              //     // Trigger search based on input
              //     context.read<SearchCubit>().search(query);
              //   },
              // ),
              buildSpacerH(10),
              // BlocListener to show SnackBar for errors
              BlocListener<SearchCubit, SearchState>(
                listenWhen: (previous, current) => current is SearchError,
                listener: (context, state) {
                  if (state is SearchError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${state.message}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        initial: () => Center(
                          child: myText(AText.searchCoupons.tr(context),),
                        ),
                        loading: () => Center(
                          child: CircularProgressIndicator(),
                        ),
                        loaded: (results) {
                          if (results.isEmpty) {
                            return Center(child: myText("No results found.".tr(context)));
                          }
                          return ListView.builder(
                            itemCount: results.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => navigateTo(
                                    context,
                                    CouponDeatlsScreen(
                                      coupon: results[index],
                                    )),
                                child: ListTile(
                                  title: Text(results[index].title),
                                ),
                              );
                            },
                          );
                        },
                        error: (message) => Center(
                          child: Text(
                              'Error: $message'), // Display error in the UI too
                        ),
                        orElse: () => Container(), // Fallback UI
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
