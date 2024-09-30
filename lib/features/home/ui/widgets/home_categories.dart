import 'package:acwadcom/features/home/ui/widgets/build_category_item.dart';
import 'package:flutter/material.dart';

class ACWHomeCategoires extends StatelessWidget {
  const ACWHomeCategoires({super.key, required this.arrayOfCategories});

  final List<CategoryModel> arrayOfCategories ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: arrayOfCategories.length,
        itemBuilder: (context,index) => buildCategoryItem(context: context,category: arrayOfCategories[index])),
    );
  }
}

class CategoryModel {
  final int? id ;
  final String title ; 
  final String image ;

  CategoryModel({this.id, required this.title, required this.image}); 

}