// ignore_for_file: file_names

import 'package:acwadcom/acwadcom_packges.dart';


class BuildListMostUserCopuns extends StatelessWidget {
  const BuildListMostUserCopuns({
    super.key,
    required this.itemWidth,  this.axis = Axis.horizontal, this.isExpanded = false,
  
  });

  final double itemWidth;
  final Axis axis;
  final bool isExpanded; 

  @override
  Widget build(BuildContext context) {
    return isExpanded ? Expanded(
      child: ListView.separated(
        scrollDirection: axis,
        itemCount: 6,
        separatorBuilder: (ctx, index) => buildSpacerH(10.0),
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity ,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              // alignment: Alignment.center,
              alignment: Alignment.center,
              children: [
                svgImage("shpaeForCode"),
                Positioned.fill(
                    child: Container(
                  margin: EdgeInsets.all(20),
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      buildFavAndCopyWgt(context),
                      // Dashed Line
                      buildDashedLine(),
                      buildAttributesWgt(context)
                    ],
                  ),
                ))
              ],
            ),
          );
        },
      ),) : SizedBox(
      height: 220.h, // Set the height for the ListView
      child: ListView.separated(
        scrollDirection: axis,
        itemCount: 6,
        separatorBuilder: (ctx, index) => buildSpacerH(10.0),
        itemBuilder: (context, index) {
          return SizedBox(
            width: itemWidth.w,
            // Responsive width
            child: Stack(
              // alignment: Alignment.center,
              children: [
                svgImage("shpaeForCode"),
                Positioned.fill(
                    child: Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      buildFavAndCopyWgt(context),
                      // Dashed Line
                      buildDashedLine(),
                      buildAttributesWgt(context)
                    ],
                  ),
                ))
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded buildFavAndCopyWgt(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Stack(
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Positioned(
              top: 10,
              left: 5,
              child: SvgPicture.asset("assets/images/_icFavorites.svg"),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height *
                    0.06, // 10% from the top of the screen
                left: MediaQuery.of(context).size.width *
                    0.02, //2% from the left of the parent
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myText(
                      "15% خصم",
                      fontSize: 12,
                      fontWeight: FontWeightEnum.Bold.fontWeight
                    ),
                    buildSpacerH(5.0),
                    InkWell(
                      child: Container(
                        height: 25.h,
                        width: 50.w,
                        // padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        decoration: const BoxDecoration(
                            color: ManagerColors.yellowColor,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: myText(
                          AText.copy.tr(context),
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeightEnum.Bold.fontWeight,
                       
                        )),
                      ),
                      onTap: (){},
                    ),
                  ],
                ))
          ]),
    );
  }

  Expanded buildAttributesWgt(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //ic Logo..
              Container(
                height: 42.h,
                width: 42.w,
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(21)),
                child: myImage("icNike", width: 27.w, height: 12.h),
              ),
              buildSpacerW(5),
              myText(
                "Nike",
                color: ManagerColors.blackTextColorexploreItem
              ),
              //
            ],
          ),
          myText(AText.codeDicount.tr(context),
              color: ManagerColors.blackTextColorexploreItem),
          //** Discount Code */
          myText("STANDR 20",
              fontSize: 14,
              fontWeight: FontWeightEnum.SemiBold.fontWeight,
              color: ManagerColors.yellowColor),
          //** deatils of Code. */
          myText("أشهر ماركات الأحذية و الملابس الرياضية ",
              fontSize: 14, fontWeight: FontWeightEnum.Regular.fontWeight),

          Row(
            children: [
              svgImage("_icClockfilled", width: 14, height: 14),
              buildSpacerW(2),
              myText(AText.endDate.tr(context),
                  fontSize: 14, color: Colors.green),
              buildSpacerW(2),
              myText("12/3/2024")
            ],
          )
        ],
      ),
    );
  }

  Expanded buildDashedLine() {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          buildSpacerH(10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              18,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Container(
                  color: Color(0xffDCDCDC),
                  height: 5.h,
                  width: 2.w,
                ),
              ),
            ),
          ),
          buildSpacerH(5.0.h),
        ],
      ),
    );
  }
}
