import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String btnName;
  final void Function()? onTap;

  const MyButton({super.key, required this.btnName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
      
        child: Text(btnName),
      ),
    );
  }
}