import 'package:flutter/material.dart';
import 'package:weight_tracker/services/auth.dart';
import 'package:weight_tracker/utils/sizeConfig.dart';
import 'package:weight_tracker/utils/strings.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        elevation: 0.0,
        title: Text(signInScreenTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _auth.signInAnon();
              },
              child: Text(signInButtonText),
            ),
          ],
        ),
      ),
    );
  }
}
