import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter_course/models/user_model.dart';

import '../services/api_handler.dart';
import '../widget/user_widget.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: FutureBuilder<List<UserModel>>(
          future: APIHandler.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("An error occurred ${snapshot.error}");
            } else if (snapshot.data == null) {
              return const Text("No products have been added yet");
            }
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, idx) {
                return ChangeNotifierProvider.value(
                  value: snapshot.data![idx],
                  child: const UserWidget(),
                );
              },
            );
            ;
          }),
    );
  }
}
