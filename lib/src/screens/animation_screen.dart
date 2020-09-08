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

  animateCat() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else {
      catController.forward();
    }
  }

  initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(
        seconds: 2,
      ),
      vsync: this,
    );

    catAnimation = Tween(begin: 0.0, end: 200.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  Widget renderCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          bottom: catAnimation.value,
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
        color: Colors.brown[300],
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
          children: [
            renderCatAnimation(),
            renderBox(),
          ],
        ),
      ),
    );
  }
}
