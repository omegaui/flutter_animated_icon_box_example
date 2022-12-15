
import 'package:flutter/material.dart';
import 'package:flutter_animated_icon_box_example/icon_box.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          IconBox(),
        ],
      ),
    );
  }

}

