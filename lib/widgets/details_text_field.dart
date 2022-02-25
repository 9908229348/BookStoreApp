import 'package:flutter/material.dart';

class CustomerDetails extends StatelessWidget {
  String text;
  TextEditingController textEditingController;
  BuildContext context;
  bool isTextEnabled;

  CustomerDetails({
    Key? key,
    required this.context,
    required this.text,
    required this.textEditingController,
    required this.isTextEnabled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 10, top: 10, bottom: 10),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          readOnly: isTextEnabled,
          controller: textEditingController,
          decoration: InputDecoration(
              hintText: text,
              labelText: text,
              contentPadding: const EdgeInsets.all(10),
              border: const OutlineInputBorder()),
        ),
      ),
    );
  }
}
