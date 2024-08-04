import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_api_flutter_course/models/categories_model.dart';
import 'package:store_api_flutter_course/screens/home_screen.dart';
import 'package:store_api_flutter_course/widget/category_widget.dart';

import '../services/api_handler.dart';
import '../widget/appbar_icons.dart';
import '../widget/category_grid.dart';
import '../widget/feeds_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: FutureBuilder<List<CategoryModel>>(
          future: APIHandler.getAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("An error occurred ${snapshot.error}");
            } else if (snapshot.data == null) {
              return const Text("No products have been added yet");
            }
            return CategoryGridWidget(categoriesList: snapshot.data!);
          }),
    );
  }
}
