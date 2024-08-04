import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter_course/consts/global_colors.dart';
import 'package:store_api_flutter_course/models/user_model.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel userModelProvider = Provider.of(context);
    Size size = MediaQuery.of(context).size;
    return ListTile(
      title: Text(userModelProvider.name.toString()),
      subtitle: Text(userModelProvider.email.toString()),
      trailing: Text(
        userModelProvider.role.toString(),
        style: TextStyle(color: lightIconsColor, fontWeight: FontWeight.bold),
      ),
      leading: FancyShimmerImage(
        height: size.width * 0.2,
        width: size.width * 0.2,
        errorWidget: Icon(
          IconlyBold.camera,
          color: Theme.of(context).colorScheme.secondary,
          size: 28,
        ),
        imageUrl: userModelProvider.avatar.toString(),
        boxFit: BoxFit.fill,
      ),
    );
  }
}
