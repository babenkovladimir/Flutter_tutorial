import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Log Me in',
        home: Scaffold(
          body: LoginScreen(),
        ));
  }
}
