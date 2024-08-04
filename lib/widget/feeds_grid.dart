import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter_course/models/products_model.dart';

import 'feeds_widget.dart';

class FeedsGridWidget extends StatelessWidget {
  const FeedsGridWidget({super.key, required this.productsList});

  final List<ProductModel> productsList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productsList.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        // Portrait mode, not fully responsive
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, idx) {
        return ChangeNotifierProvider.value(
            value: productsList[idx],
            child: const FeedsWidget());
      },
    );
  }
}
