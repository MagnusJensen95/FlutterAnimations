import 'dart:math';

import 'package:GriderAnimations/src/widgets/cat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  createState() => AnimationScreenState();
}

class AnimationScreenState extends State<AnimationScreen>
    with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> boxAnimation;
  AnimationController boxController;

  animateCat() {
    boxController.forward();
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else {
      catController.forward();
    }
  }

  double piToDegrees(int degrees) {
    return (pi / 180) * degrees;
  }

  initState() {
    super.initState();

    boxController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 2000,
      ),
    );

    boxAnimation = Tween(begin: piToDegrees(120), end: piToDegrees(100))
        .animate(CurvedAnimation(
      curve: Curves.linear,
      parent: boxController,
    ));

    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.repeat();
      }
    });

    catController = AnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
      vsync: this,
    );

    catAnimation = Tween(begin: -40.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  Widget renderLeftBoxFlap() {
    return Positioned(
        left: 5,
        child: AnimatedBuilder(
            animation: boxAnimation,
            child: Container(
              width: 125,
              height: 10,
              color: Colors.brown,
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: boxAnimation.value,
                alignment: Alignment.topLeft,
                child: child,
              );
            }));
  }

  Widget renderRightBoxFlap() {
    return Positioned(
        right: 5,
        child: AnimatedBuilder(
            animation: boxAnimation,
            child: Container(
              width: 125,
              height: 10,
              color: Colors.brown,
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: boxAnimation.value,
                alignment: Alignment.topLeft,
                child: child,
              );
            }));
  }

  Widget renderCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0,
          left: 0,
        );
      },
      child: Cat(),
    );
  }

  Widget renderBox() {
    return GestureDetector(
      child: Container(
        height: 200,
        width: 200,
        color: Colors.brown,
      ),
      onTap: animateCat,
    );
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crisp Animations'),
      ),
      body: Center(
        child: Stack(
          overflow: Overflow.visible,
          children: [
            renderCatAnimation(),
            renderBox(),
            renderLeftBoxFlap(),
            renderRightBoxFlap(),
          ],
        ),
      ),
    );
  }
}
