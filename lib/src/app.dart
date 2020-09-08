import 'package:GriderAnimations/src/screens/animation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  build(context) {
    return MaterialApp(
      title: 'Jadak',
      home: AnimationScreen(),
      theme: ThemeData(primarySwatch: Colors.amber),
    );
  }
}
