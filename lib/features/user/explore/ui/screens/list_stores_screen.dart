import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/user/explore/data/store_model.dart';
import 'package:acwadcom/features/user/explore/logic/cubit/explore_cubit.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_list_featured_stores.dart';
import 'package:acwadcom/features/user/explore/ui/widget/build_store_card.dart';

import '../../../../../models/user_model.dart';
import '../widget/build_list_of_all_stores.dart';

class ListStoresScreen extends StatefulWidget {
  // final List<StoreModel> stores;

  const ListStoresScreen({super.key});

  @override
  State<ListStoresScreen> createState() => _ListStoresScreenState();
}

class _ListStoresScreenState extends State<ListStoresScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<>()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: buildAppBarWithBackButton(context, isRTL(context),
            title: AText.stores.tr(context)),
        body: BlocBuilder<ExploreCubit , ExploreState>(
            buildWhen: (current, previous) =>
                current is SucessGetStores ||
                current is FaluireGetStores ||
                current is LoadingStores,
            builder: (context, state) {
              return state.maybeWhen(
              loadingStores: () => Center(child: BuildCustomLoader()),
              faluireGetStores: (error) => setupError() ,
              sucessGetStores: (stores) => setupSuccess(stores),
              orElse: (){
                return const SizedBox.shrink();
              });
            }));
  }

  Widget setupSuccess(stores) {
    return BuildlistOfAllStores(stores: stores,);
  }

  Widget setupError() {
    return const SizedBox.shrink();
  }
}

