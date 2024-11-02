import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/home/ui/widgets/build_category_item.dart';
import 'package:acwadcom/models/category_model.dart';

class ACWHomeCategoires extends StatefulWidget {
  const ACWHomeCategoires({super.key, required this.arrayOfCategories});

  final List<CategoryModel> arrayOfCategories;

  @override
  State<ACWHomeCategoires> createState() => _ACWHomeCategoiresState();
}

class _ACWHomeCategoiresState extends State<ACWHomeCategoires> {
    var selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.arrayOfCategories.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                selectedCategoryIndex = index;
              });
              context.read<HomeCubit>().emitSelectedCategory(index);

            },
            child: buildCategoryItem(
                context: context, category: widget.arrayOfCategories[index] , 
                selectedIndex: selectedCategoryIndex ,
                itemIndex: index,

                )
          )),
    );
  }
}
