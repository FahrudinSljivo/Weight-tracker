import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.grey[600],
          size: 50.0,
        ),
      ),
    );
  }
}
