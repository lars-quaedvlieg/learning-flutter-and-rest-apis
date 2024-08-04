import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter_course/screens/home_screen.dart';

import '../models/products_model.dart';
import '../services/api_handler.dart';
import '../widget/appbar_icons.dart';
import '../widget/feeds_widget.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<ProductModel> productsList = [];

  @override
  void didChangeDependencies() {
    getProducts();
    super.didChangeDependencies();
  }

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: productsList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: productsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                // Portrait mode, not fully responsive
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 0.67,
              ),
              itemBuilder: (context, idx) {
                return ChangeNotifierProvider.value(
                    value: productsList[idx], child: const FeedsWidget());
              },
            ),
    );
  }
}
