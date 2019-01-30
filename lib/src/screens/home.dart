import 'package:flutter/material.dart';

import '../widgets/cat.dart';

class Home extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    return HomeState();
//  }
  createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController; // controls our animation - start, restart stop?

  @override
  void initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    catAnimation = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(parent: catController, curve: Curves.easeIn),
    );
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    } // Запускает анимацию???
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            children: <Widget>[
              buildBox(),
              buildCatAnimation(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  // Мы возвращаем в контейнер чяйлда. Для того, чтобы
  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          bottom: catAnimation.value,
        );

        Container(
          child: child,
          margin: EdgeInsets.only(top: catAnimation.value),
        );
      },
      child: Cat(),
    );

    Cat();
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }
}
