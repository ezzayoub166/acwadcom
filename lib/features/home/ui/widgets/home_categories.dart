import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/home/ui/widgets/build_category_item.dart';
import 'package:acwadcom/models/category_model.dart';

class ACWHomeCategoires extends StatelessWidget {
  const ACWHomeCategoires({super.key, required this.arrayOfCategories});

  final List<CategoryModel> arrayOfCategories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: arrayOfCategories.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => context.read<HomeCubit>().emitSelectedCategory(index),
            child: buildCategoryItem(
                context: context, category: arrayOfCategories[index]),
          )),
    );
  }
}
