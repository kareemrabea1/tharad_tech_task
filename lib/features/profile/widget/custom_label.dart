import 'package:flutter/material.dart';

class buildLabel extends StatelessWidget {
  const buildLabel({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10,
            fontFamily: 'Tajawal',
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
