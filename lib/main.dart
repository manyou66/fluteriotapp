import 'package:flutter/material.dart';
import 'package:iotapps/screens/authen.dart';
import 'package:iotapps/screens/my_service.dart';
import 'package:iotapps/screens/register.dart';
main() {
  runApp(Myapps());
}
class Myapps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authen(),
    );
  }
}
