import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: <Widget>[emailFields(), passwordField(), Container(margin: EdgeInsets.only(top: 25.0)), submitButton()],
        ),
      ),
    );
  }

  Widget emailFields() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'Email Address', hintText: 'you@example.com'),
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter Password', hintText: 'Password'),
      //obscureText: true,
    );
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Submit'),
      onPressed: () {},
    );
  }
}
