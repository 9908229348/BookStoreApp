import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function callBack;
  String text;

  CustomButton({Key? key, required this.callBack, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text),
      style: ElevatedButton.styleFrom(
        maximumSize: const Size(10, 5),
      ),
      onPressed: () {
        callBack();
      },
    );
  }
}
