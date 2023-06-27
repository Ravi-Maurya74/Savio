import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final IconData iconData;
  final String hint;
  // final VoidCallback onTap;

  CustomTextField({
    required this.textEditingController,
    required this.label,
    required this.iconData,
    // required this.onTap,
    this.hint = '',
    Key? key,
  }) : super(key: key);

  String? text;

  String getText() {
    return text!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 8),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(37, 42, 52, 1),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: Icon(
                iconData,
                color: Colors.white.withOpacity(0.7),
              )),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                label: Text(label),
                hintStyle: Theme.of(context).textTheme.bodySmall,
                hintText: hint,
              ),
              controller: textEditingController,
              autofillHints: gethints(label),
            ),
          ),
        ],
      ),
    );
  }
}

Iterable<String> gethints(String label) {
  if (label == 'Email') {
    return [AutofillHints.email];
  } else if (label == 'Full Name') {
    return [AutofillHints.name];
  } else {
    return [];
  }
}
