import 'package:flutter/material.dart';

import '../widget/user_widget.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, idx) {
          return const UserWidget();
        },
      ),
    );
  }
}
