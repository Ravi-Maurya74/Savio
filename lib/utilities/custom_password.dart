import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String label;
  final IconData iconData;
  const CustomPasswordField({
    required this.textEditingController,
    required this.label,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscure = true;
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
                widget.iconData,
                color: Colors.white.withOpacity(0.7),
              )),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                label: Text(widget.label),
                // labelStyle: TextStyle(color: Colors.white),
              ),
              obscureText: obscure,
              controller: widget.textEditingController,
              autofillHints: const [AutofillHints.password],
            ),
          ),
          if (widget.label == 'Password') ...[
            IconButton(
              onPressed: () {
                setState(() {
                  obscure = !obscure;
                });
              },
              icon: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ]
        ],
      ),
    );
  }
}