import 'dart:developer';

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
  final ScrollController _scrollController = ScrollController();
  List<ProductModel> productsList = [];
  int limit = 10;
  bool _isLimit = false;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        limit += 10;
        if (limit == 50) {
          _isLimit = true;
          setState(() {});
          return;
        }
        await getProducts();
        log("limit: $limit");
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProducts(limit: limit.toString());
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
          : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  GridView.builder(
                    itemCount: productsList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                  if (!_isLimit)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
    );
  }
}
