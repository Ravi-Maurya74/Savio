import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.dimensions,
    required this.label,
    required this.action,
  }) : super(key: key);

  final Size dimensions;
  final String label;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(147, 58, 241, 1),
          Color.fromRGBO(193, 81, 166, 1),
          Color.fromRGBO(247, 109, 78, 1),
          // Theme.of(context).colorScheme.primary
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          onTap: () {
            HapticFeedback.vibrate();

            action();
          },
          splashColor: Colors.white.withOpacity(0.5),
          enableFeedback: true,
          child: Container(
            width: dimensions.width * 0.8,
            padding: const EdgeInsets.all(20),
            child: Center(child: Text(label)),
          ),
        ),
      ),
    );
  }
}
