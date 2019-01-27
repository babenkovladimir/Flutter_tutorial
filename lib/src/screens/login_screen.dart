import 'package:flutter/material.dart';

import '../blocs/bloc.dart';
import '../blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(bloc),
          passwordField(bloc),
          Container(margin: EdgeInsets.only(top: 25.0)),
          submitButton(bloc),
        ],
      ),
    );
  }

  // Каждый раз, когда в стрим приходи информация, виджет перерислвавается. И всё находится в snapshot

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        //snapshot - contains information all from the stream
        return TextField(
//          onChanged: (newValue) {bloc.changeEmail(newValue);} // onChange function calls directly},
          onChanged:
              bloc.changeEmail, // второй вариан вызова функции - напрямую.
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: 'you@example.com',
              labelText: 'Email Address',
              errorText: snapshot.error),
//              errorText: 'invalid email'),
        );
      },
    );
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'password',
              labelText: 'Password',
              errorText: snapshot.error),
        );
      },
    );
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Login'),
          color: Colors.blue,
          onPressed: snapshot.hasData
              ? () {
                  bloc.submit();
                }
              : null,
        );
      },
    );
    //return
  }
}
