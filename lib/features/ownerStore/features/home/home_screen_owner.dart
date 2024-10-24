// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/ownerStore/features/home/logic/home_owner/home_owner_cubit.dart';
import 'package:acwadcom/features/ownerStore/features/home/logic/home_owner/home_owner_state.dart';
import 'package:acwadcom/features/user/explore/logic/cubit/explore_cubit.dart';
import 'package:acwadcom/features/user/home/data/category_repository.dart';
import 'package:acwadcom/features/user/home/logic/avatar/avatar_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_featured_code.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/category_model.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/features/ownerStore/features/home/no_coupon_screen.dart';
import 'package:acwadcom/features/ownerStore/features/home/widgets/custom_drawer.dart';
import 'package:acwadcom/features/ownerStore/features/home/widgets/custom_pop_dialog_delete.dart';

class HomeScreenOwner extends StatefulWidget {
  const HomeScreenOwner({super.key});

  @override
  State<HomeScreenOwner> createState() => _HomeScreenOwnerState();
}

class _HomeScreenOwnerState extends State<HomeScreenOwner> {
  List<String> items = [];

// Function to show the dialog
  void showConfirmDeleteDialog(BuildContext context, String codeName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          codeName: codeName,
          couponID: '',
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AvatarCubit>(context).loadProfileData();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    List<CategoryModel> categories =
        await getIt<CategoryRepository>().getAllCategories();
    bLISTOFCATEGORY = categories;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeOwnerCubit>()..emitGetCoupons(),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: ListView(
              children: [
                buildAppBar(),
                buildSpacerH(10.0),
                 Column(
                        children: [
                          TSectionHeader(
                            title: "Your coupons".tr(context),
                            textColor: ManagerColors.textColor,
                          ),
                          buildSpacerH(TSizes.spaceBtwItems),
                          BlocBuilder<HomeOwnerCubit, HomeOwnerState>(
                      
                              buildWhen: (previous, current) =>
                                  current is LoadingGetCouponsForOwner ||
                                  current is SuccessGetCouponsForOwner ||
                                  current is FaluireGetCouponsForOwner ||
                                  current is EmptyCouponsForOwner,
                              builder: (context, state) {
                                return state.maybeWhen(
                                    loadingGetCouponsForOwner: () =>
                                        BuildCustomLoader(),
                                    successGetCouponsForOwner: (coupons) =>
                                        setUpSuccess(coupons),
                                    faluireGetCouponsForOwner: (error) =>
                                        SizedBox.shrink(),
                                        emptyCouponsForOwner: () => NoCouponsScreen(),
                                        
                                    orElse: () {
                                      return SizedBox.shrink();
                                    });
                              }),
                          
                        ],
                      )
              ],
            ),
          ),
          drawer: CustomDrawer()),
    );
  }

  BlocBuilder<dynamic, dynamic> buildAppBar() {
    return BlocBuilder<AvatarCubit, AvatarState>(
      buildWhen: (previous, current) => current is FetchNameImage,
      builder: (context, state) {
        return AppBar(
            centerTitle: true,
            title: myText(
              state.username,
            ),
            actions: [
              // SizedBox(
              //   width: 20,
              // ),
              if (state.imageUrl == "")
                CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.png"))
              else
                CircleAvatar(
                  radius: 15,
                  backgroundColor: ManagerColors.myWhite,
                  backgroundImage: CachedNetworkImageProvider(
                    state.imageUrl,
                  ),
                ),
              // SizedBox(
              //   width: 20,
              // ),
            ]);
      },
    );
  }

  Widget setUpSuccess(List<Coupon> coupons) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          return InkWell(
              onTap: () {
                navigateNamedTo(context, Routes.storeOwnerDiscountCodeDetails);
              },
              child: BuildFeaturedCode(
                coupon: coupons[index],
                isShowRemove: true,
              ));
        },
        separatorBuilder: (ctx, index) => buildSpacerH(10.0),
        itemCount: coupons.length);
  }
}
