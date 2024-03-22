import 'package:flutter/material.dart';

class ButtonCard extends StatefulWidget {
  final String text;
  final VoidCallback onPress;

  const ButtonCard({super.key, required this.text, required this.onPress});

  @override
  State<ButtonCard> createState() => _ButtonCardState();
}

class _ButtonCardState extends State<ButtonCard> {
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: widget.onPress,
      style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.cyan),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)))),
      child: Text(widget.text, style:const TextStyle(color: Colors.white , fontSize: 24, fontWeight: FontWeight.bold ) ,),
    );
  }
}
