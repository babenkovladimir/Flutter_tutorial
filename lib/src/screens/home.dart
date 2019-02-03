import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/cat.dart';

class Home extends StatefulWidget {

  @override
  createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController; // controls our animation - start, restart stop?
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    super.initState();

    boxController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );

    boxAnimation = Tween(
      begin: pi * 0.6,
      end: pi * 0.65,
    ).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeInOut,
      ),
    );

    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    catAnimation = Tween(
      begin: -35.0,
      end: -80.0,
    ).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );

    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });

    boxController.forward();
  }

  onTap() {
    boxController.stop();

    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    } else if (catController.status == AnimationStatus.dismissed) {
      boxController.stop();
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
              buildCatAnimation(), // Странно, ведь кот пампится раньше, а выглядит сверзу
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
            overflow: Overflow.visible,
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
//          bottom: catAnimation.value, // Для того, чтобы анимация начиналассь не снизу, а сверху меняем bottom to top
          top: catAnimation.value,
          right: 0.0, // Ограничения!!! Накладываются для стека???
          left: 0.0,
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

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10,
          width: 125,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            angle: boxAnimation.value,
            alignment: Alignment.topLeft,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10,
          width: 125,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            angle: -boxAnimation.value,
            alignment: Alignment.topRight,
          );
        },
      ),
    );
  }
}
