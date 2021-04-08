import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/models/userModel.dart';
import 'package:weight_tracker/screens/home/home.dart';
import 'package:weight_tracker/screens/signIn/signIn.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return user == null ? SignIn() : Home();
  }
}
