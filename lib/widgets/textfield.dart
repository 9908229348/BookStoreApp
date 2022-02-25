import 'package:bookstore_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class InputTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final bool isEmail;
  final TextEditingController textEditingController;
  final Function validation;

  InputTextField(
      {Key? key,
      required this.icon,
      required this.hintText,
      required this.isPassword,
      required this.isEmail,
      required this.textEditingController,
      required this.validation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: textEditingController,
        validator: (value) => validation(value),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: ColorsPalette.iconColor,
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorsPalette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorsPalette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35.0))),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle:
                const TextStyle(fontSize: 14, color: ColorsPalette.textColor1)),
      ),
    );
  }
}
