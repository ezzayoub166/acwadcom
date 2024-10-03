
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/admin/ui/screens/edit_code_screen_admin.dart';
import 'package:acwadcom/ownerStore/features/home/widgets/custom_pop_dialog_delete.dart';

class BuildItmCodeForAdmin extends StatelessWidget {
  const BuildItmCodeForAdmin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xffF2F2F2), width: 2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //image of store ....
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  color: ManagerColors.greyLighColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: myImage("icNike")),
            ),

            //attributes => name of store , dicsount % , numer of use times ..
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    myText(
                      "Nike",
                     color: ManagerColors.textColorDark,
                     fontSize: 18
                    ),
                    buildSpacerW(MediaQuery.of(context).size.width * 0.3),
                    Row(
                      children: [
                          InkWell(
                      child: svgImage("_icRemove", height: 20, width: 20),
                      onTap: () {
                        showConfirmDeleteDialog(context, "دايدس ");
                      },
                    ),
                    buildSpacerW(10),
                    InkWell(
                      child: svgImage("edit", height: 20, width: 20),
                      onTap: () {
                        navigateNamedTo(context, Routes.editCodeScreenAdmin);
                      },
                    )
                      ],
                    )
                  
                  ],
                ),
                myText(
                  "15% ${AText.discount.tr(context)}",
                  color : ManagerColors.kCustomColor,
                  fontWeight: FontWeightEnum.Bold.fontWeight,
                  fontSize: 20
                  
                ),
                Row(
                  children: [
                    svgImage("profile-tick", height: 18, width: 18),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: AText.numberOfuse,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: ManagerColors.textColorDarkDouble)),
                      TextSpan(
                          text: ":",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: ManagerColors.textColorDarkDouble)),
                      TextSpan(
                          text: " 2389",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: ManagerColors.textColor))
                    ])),
                  ],
                ),
              ],
            ),
            //Favorite button..
          ],
        ));
  }

  // Function to show the dialog
  void showConfirmDeleteDialog(BuildContext context, String codeName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(codeName: codeName);
      },
    );
  }
}
