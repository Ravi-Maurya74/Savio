import 'package:flutter/material.dart';

class Notificationtile extends StatelessWidget {
  final bool isCrossed;
  Notificationtile({required this.isCrossed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        isCrossed
            ? Positioned(
                left: 15,
                bottom: 15,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 8,
                    minHeight: 8,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
