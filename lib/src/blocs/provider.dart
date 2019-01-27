import 'package:flutter/material.dart';

import 'bloc.dart';

class Provider extends InheritedWidget {
//  @override
//  bool updateShouldNotify(InheritedWidget oldWidget) {
//    return null;
//  }

  final bloc = Bloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}
