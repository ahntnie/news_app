import 'package:flutter/material.dart';

import '../Model/User.dart';

class UserView extends StatelessWidget {
  final Users user;

  const UserView({
    required this.user,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(user.name),
    );
  }
}
