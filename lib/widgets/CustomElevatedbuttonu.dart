import 'package:flutter/material.dart';

class Custombuttonu extends StatelessWidget {
  final String TextButton;
  final VoidCallback onpr;
  final Size? siz;
  final TextStyle? textStyle;
  final Color? backg;
  const Custombuttonu({
    required this.TextButton,
    required this.onpr,
    this.siz,
    this.textStyle,
    this.backg,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:  ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor:backg,
              fixedSize: siz
          ),
          child: Text(
            TextButton,
            style: textStyle,
          ),
          onPressed: onpr
      ),
    );
  }
}
