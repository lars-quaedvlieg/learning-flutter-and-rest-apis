import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:store_api_flutter_course/consts/global_colors.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      title: Text("Username"),
      subtitle: Text("mail@gmail.com"),
      trailing: Text(
        "User role",
        style: TextStyle(color: lightIconsColor, fontWeight: FontWeight.bold),
      ),
      leading: FancyShimmerImage(
        height: size.width * 0.2,
        width: size.width * 0.2,
        errorWidget: const Icon(
          IconlyBold.danger,
          color: Colors.red,
          size: 28,
        ),
        imageUrl: "https://i.ibb.co/vwB46Yq/shoes.png",
        boxFit: BoxFit.fill,
      ),
    );
  }
}
