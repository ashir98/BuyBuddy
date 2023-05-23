// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {
  String title;
  final void Function()? onPressed;
  PrimaryButton({required this.onPressed,required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title, style: TextStyle(color: Colors.white,fontSize: size.width*0.053)),
      ),
    );
  }
}
