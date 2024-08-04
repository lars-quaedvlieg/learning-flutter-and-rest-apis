import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter_course/models/categories_model.dart';
import 'package:store_api_flutter_course/widget/category_widget.dart';

class CategoryGridWidget extends StatelessWidget {
  const CategoryGridWidget({super.key, required this.categoriesList});

  final List<CategoryModel> categoriesList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // Portrait mode, not fully responsive
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, idx) {
        return ChangeNotifierProvider.value(
            value: categoriesList[idx], child: const CategoryWidget());
      },
    );
  }
}
