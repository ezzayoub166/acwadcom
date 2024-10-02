// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/home/ui/widgets/build_discont_slider.dart';
import 'package:acwadcom/features/home/ui/widgets/build_tow_bottns_for_filter.dart';
import 'package:acwadcom/features/home/ui/widgets/home_categories.dart';

class BuildFilterBottomSheet extends StatefulWidget {
  const BuildFilterBottomSheet({super.key});

  @override
  State<BuildFilterBottomSheet> createState() => _BuildFilterBottomSheetState();
}

class _BuildFilterBottomSheetState extends State<BuildFilterBottomSheet> {

  int selecttedId = 1;

  @override
  Widget build(BuildContext context) {
    var arrayOfCategories = [
      CategoryModel(title: AText.all.tr(context), image: "_icAll", id: 1),
      CategoryModel(
          title: AText.groceries.tr(context),
          image: "_icShoppingBasket",
          id: 2),
      CategoryModel(title: AText.resturnts.tr(context), image: "icBell", id: 3),
      CategoryModel(
          title: AText.delivery.tr(context),
          image: "_icDelivery_svgrepo",
          id: 4),
      CategoryModel(title: AText.fashion.tr(context), image: "_icDress", id: 5),
    ];

    return Container(
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
              buildListCategories(arrayOfCategories, context),
            ],
          ),
          buildSpacerH(10.0),
          // TSectionHeader(title: AText.codeDicount.tr(context)),
          DiscountSlider(),
          buildSpacerH(10),
          ButtonRowApplyCancle()
        ],
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
                selecttedId = arrayOfCategories[idx].id ?? 1;
                setState(() {});
              },
              child: Container(
                  // height: 30.h,
                  // width: 50.w,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: selecttedId == arrayOfCategories[idx].id
                          ? ManagerColors.kCustomColor
                          : Color(0xffE4E4E4),
                      border:
                          Border.all(width: 1, color: ManagerColors.greyColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: myText(
                    arrayOfCategories[idx].title,
                    fontSize: 14,
                    fontWeight: FontWeightEnum.Medium.fontWeight,
                    color: selecttedId == arrayOfCategories[idx].id
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
