import 'package:flutter/material.dart';

import '../Model/Users.dart';

class UserView extends StatelessWidget {
  final Users user;

  const UserView({super.key, 
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(user.name),
    );
  }
}
