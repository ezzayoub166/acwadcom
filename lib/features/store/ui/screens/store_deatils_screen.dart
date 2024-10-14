import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/explore/data/store_model.dart';
import 'package:acwadcom/features/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/home/ui/home_screen.dart';
import 'package:acwadcom/features/home/ui/widgets/build_featured_code.dart';

class StoreDeatilsScreen extends StatefulWidget {
  final StoreModel store;
  const StoreDeatilsScreen({super.key, required this.store});

  @override
  State<StoreDeatilsScreen> createState() => _StoreDeatilsScreenState();
}

class _StoreDeatilsScreenState extends State<StoreDeatilsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeCubit>(context).emitGetCoupons();
  }
  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: ManagerColors.kCustomColor,
                height: 200.h,
                width: double.infinity,
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  backgroundColor: ManagerColors.kCustomColor,
                  leading: Padding(
                    padding: EdgeInsets.only(
                      left: Localizations.localeOf(context).languageCode == 'ar'
                          ? 0
                          : 16, // Padding for English
                      right:
                          Localizations.localeOf(context).languageCode == 'ar'
                              ? 16
                              : 0, // Padding for Arabic
                    ),
                    child: InkWell(
                      child:
                          svgImage("arrow-circle-left", isRtl: isRTL(context)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, // Padding for English
                          right: 16 // Padding for Arabic
                          ),
                      child: InkWell(
                        child: svgImage("_icGrayHeart", isRtl: isRTL(context)),
                        onTap: () {
                          //** TOTO heart Store.... */
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                )),
            Positioned.fill(
                left: 10,
                right: 10,
                top: 130.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 60.r,
                        backgroundColor: ManagerColors.kCustomColor,
                        backgroundImage: NetworkImage(widget.store.imageUrl)),
                    myText(widget.store.name,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ManagerColors.kCustomColor),
                    BlocBuilder<HomeCubit, HomeState>(
                      buildWhen: (previous, current) => current is SuccessFeatchedCoupons || current is LoadingCoupons || current is ErrorFeatchedCoupons,
                      builder: (context, state) {
                        return state.maybeWhen(
                          successFeatchedCoupons: (coupons) => BuildListCoupons(coupons: coupons),
                          loadingCoupons: () => BuildCustomLoader(),
                          orElse: ()=> BuildCustomLoader());
                      },
                    )
                    // BuildListMostUserCopuns(itemWidth: itemWidth , axis: Axis.vertical,isExpanded: true,)
                  ],
                ))
          ],
        ));
  }
}
