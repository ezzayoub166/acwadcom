// ignore_for_file: prefer_const_constructors
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_tow_bottns_for_filter.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/category_model.dart';

class BuildFilterBottomSheet extends StatefulWidget {
  const BuildFilterBottomSheet({super.key});

  @override
  State<BuildFilterBottomSheet> createState() => _BuildFilterBottomSheetState();
}

class _BuildFilterBottomSheetState extends State<BuildFilterBottomSheet> {

  String selecttedId = "PI6L0IN9nDARotHfJNaW";
    // The value index corresponds to a list of percentage options.
  int _currentIndex = 1; // 1 corresponds to 15%

  // List of discount options
  final List<int> _discountOptions = [5,10, 15, 30];

  @override
  Widget build(BuildContext context) {
    // var arrayOfCategories = [
    //   CategoryModel(title: AText.all.tr(context), image: "_icAll"),
    //   CategoryModel(
    //       title: AText.groceries.tr(context),
    //       image: "_icShoppingBasket",
    //       ),
    //   CategoryModel(title: AText.resturnts.tr(context), image: "icBell"),
    //   CategoryModel(
    //       title: AText.delivery.tr(context),
    //       image: "_icDelivery_svgrepo",
    //      ),
    //   CategoryModel(title: AText.fashion.tr(context), image: "_icDress"),
    // ];

    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..emitGetCategories(),
      child: Container(
        height: 380,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            myText(AText.applayFilter.tr(context),
                fontSize: 20,
                fontWeight: FontWeightEnum.Bold.fontWeight,
                color: ManagerColors.kCustomColor),
            buildSpacerH(10.0),
      
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myText(
                  AText.categorieslbl.tr(context),
                  fontSize: 20,
                  color: ManagerColors.kCustomColor,
                  textAlign: TextAlign.end,
                  fontWeight: FontWeight.bold,
                ),
      
                buildSpacerH(5.0),
                //** List Of Categories */
                BlocBuilder<HomeCubit , HomeState>(
                  buildWhen: (previous, current) => current is LoadingCatgories || current is SuccessFeatchedCatgories || current is ErrorFeatchedCatgories,
                  builder: (context,state){
                    return state.maybeWhen(
                      loadingCatgories: () => BuildCustomLoader(),
                      successFeatchedCatgories: (categories) =>buildListCategories(categories, context) ,
                      errorFeatchedCatgories: (error) => SizedBox.shrink(child: Center(child: myText(error)),),
                      
                      orElse: () => SizedBox.shrink());
                  } ,
                   
                
                )
                ,
              ],
            ),
            buildSpacerH(10.0),
            // TSectionHeader(title: AText.codeDicount.tr(context)),
            Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        myText(
          AText.discontrate.tr(context),
          fontSize: 20, 
          color: ManagerColors.kCustomColor,
          
          fontWeight: FontWeight.bold,
        ),
        buildSpacerH(5.0),
               Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _discountOptions.map((option) {
            return Text(
              '$option%',
              style: TextStyle(
                fontSize: 16,
                
                fontWeight: _discountOptions[_currentIndex] == option
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: _discountOptions[_currentIndex] == option
                    ?ManagerColors.kCustomColor

                    : Colors.grey,
              ),
            );
          }).toList(),
        ),
      buildSpacerH(5.0),

        Slider(
          value: _currentIndex.toDouble(),
          min: 0,
          max: 2,
          divisions: 2,
          activeColor: Colors.orange,
          inactiveColor: Colors.grey.shade300,
          onChanged: (double value) {
            setState(() {
              _currentIndex = value.toInt();
            });
          },
        ),
 
      ],
    ),
            buildSpacerH(10),
            ButtonRowApplyCancle(categoryID: selecttedId, rate:_discountOptions[_currentIndex])
          ],
        ),
      ),
    );
  }

  SizedBox buildListCategories(
      List<CategoryModel> arrayOfCategories, BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, idx) {
            return InkWell(
              onTap: () {
                selecttedId = arrayOfCategories[idx].categoryId! ;
                setState(() {});
                // isSelected = true;
              },
              child: Container(
                  height: 50,
                  // width: 50.w,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: selecttedId == arrayOfCategories[idx].categoryId!
                          ? ManagerColors.kCustomColor
                          : Color(0xffE4E4E4),
                      border:
                          Border.all(width: 1, color: ManagerColors.greyColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: myText(
                    arrayOfCategories[idx].title,
                    fontSize: 14.sp,
                    fontWeight: FontWeightEnum.Medium.fontWeight,
                    color: selecttedId == arrayOfCategories[idx].categoryId
                        ? Colors.white
                        : ManagerColors.kCustomColor,
                  )),
            );
          },
          separatorBuilder: (ctex, index) => buildSpacerW(5.0),
          itemCount: arrayOfCategories.length),
    );
  }
}
