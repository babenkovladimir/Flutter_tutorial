import 'package:flutter/material.dart';

import '../mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
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
      validator: validateEmail,
      onSaved: (String value) {
        print(value);
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter Password', hintText: 'Password'),
      validator: validatePassword,
      onSaved: (String value) {
        print(value);
        password = value;
      },
      //obscureText: true,
    );
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Submit'),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('time to post $email and $password');
        }
      },
    );
  }
}
