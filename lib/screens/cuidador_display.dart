import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipable_stack/swipable_stack.dart';

class CuidadorScreen extends StatefulWidget {
  const CuidadorScreen({super.key});

  @override
  State<CuidadorScreen> createState() => _CuidadorScreenState();
}

class _CuidadorScreenState extends State<CuidadorScreen> {
  int currentIndex = 0;
  final controller = SwipableStackController();

  var imageList = [
    'assets/images/cuidador1.jpeg',
    'assets/images/cuidador2.jpeg',
    'assets/images/cuidador3.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuidadores'),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .7,
            width: MediaQuery.of(context).size.width,
            child: SwipableStack(
              overlayBuilder: (context, properties) {
                final opacity = min(properties.swipeProgress, 1.0);
                final isRight = properties.direction == SwipeDirection.right;
                return Opacity(
                  opacity: isRight ? opacity : 0,
                );
              },
              controller: controller,
              itemCount: imageList.length,
              builder: (context, properties) {
                return Image.asset(
                  imageList[properties.index],
                  fit: BoxFit.cover,
                );
              },
              onSwipeCompleted: (index, direction) {
                setState(() {
                  if (direction == SwipeDirection.right ||
                      direction == SwipeDirection.left) {
                    currentIndex++;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0, bottom: 50),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () => controller.rewind(),
                tooltip: 'Rewind',
                child: const Icon(FontAwesomeIcons.x),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 22.0, bottom: 50),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.green[700],
                onPressed: () => controller.currentIndex = 0,
                tooltip: 'reset',
                child: const Icon(FontAwesomeIcons.solidHeart),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

