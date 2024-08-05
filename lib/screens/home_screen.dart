import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_api_flutter_course/screens/category_screen.dart';
import 'package:store_api_flutter_course/screens/feeds_screen.dart';
import 'package:store_api_flutter_course/screens/user_screen.dart';
import 'package:store_api_flutter_course/services/api_handler.dart';
import 'package:store_api_flutter_course/widget/appbar_icons.dart';
import 'package:store_api_flutter_course/widget/sale_widget.dart';

import '../models/products_model.dart';
import '../widget/feeds_grid.dart';
import '../widget/feeds_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;

  // List<ProductModel> productsList = [];

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   getProducts();
  //   super.didChangeDependencies();
  // }
  //
  // Future<void> getProducts() async {
  //   productsList = await APIHandler.getAllProducts();
  //   setState(() {
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          leading: AppBarIcons(
            function: () {
              Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const CategoryScreen(),
                  ));
            },
            icon: IconlyBold.category,
          ),
          actions: [
            AppBarIcons(
              function: () {
                Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const UserScreen(),
                    ));
              },
              icon: IconlyBold.user3,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    IconlyLight.search,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  hintText: "Search",
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: size.height * 0.25,
                    child: Swiper(
                      itemCount: 3,
                      autoplay: true,
                      pagination: const SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                          color: Colors.white,
                          activeColor: Colors.red,
                        ),
                      ),
                      control: const SwiperControl(),
                      itemBuilder: (context, idx) {
                        return const SaleWidget();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          "All Products",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        AppBarIcons(
                            function: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: const FeedsScreen(),
                                  ));
                            },
                            icon: IconlyBold.arrowRight2),
                      ],
                    ),
                  ),
                  FutureBuilder<List<ProductModel>>(
                      future: APIHandler.getAllProducts(limit: "3"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text("An error occurred ${snapshot.error}");
                        } else if (snapshot.data == null) {
                          return const Text("No products have been added yet");
                        }
                        return FeedsGridWidget(productsList: snapshot.data!);
                      }),
                ],
              ))),
            ],
          ),
        ),
      ),
    );
  }
}
