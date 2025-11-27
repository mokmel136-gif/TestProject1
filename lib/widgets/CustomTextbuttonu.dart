import 'package:flutter/material.dart';

class CustomTextbuttonu extends StatelessWidget {
  final VoidCallback onprtext;
  final String TextBu;
  const CustomTextbuttonu({
    required this.TextBu,
    required this.onprtext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        onPressed: onprtext,
        child: Text(
          TextBu,
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 21, // fontWeight:FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
