import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'validators.dart';

// Рефакторим. Меняем из стрим контроллера в reactive
//class Bloc extends Validators {
class Bloc extends Object with Validators {
//  final _email = StreamController<String>.broadcast();
//  final _password = StreamController<String>.broadcast();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Add data to the stream
//  Stream<String> get email => _email.stream.add;
  Stream<String> get email => _email.stream.transform(validateEmail);

//  Stream<String> get password => _password.stream.add;
  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  // Change data

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print(validEmail);
    print(validPassword);
  }

  // close Stream controllers
  dispose() {
    _email.close();
    _password.close();
  }
}

// This is solution for single instance for hole application;
//final bloc = Bloc(); // This line is c=deleted from code becouse of using GlobalScope vsariable of this blic pattern
