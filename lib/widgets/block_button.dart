import 'package:flutter/material.dart';

class BlockButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;

  final buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    padding: const EdgeInsets.all(20),
    backgroundColor: Colors.black,
  );

  BlockButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: buttonStyle, onPressed: onPressed, child: Text(label))),
    );
  }
}
