import 'package:flutter/material.dart';

class ProfileStackDesign extends StatelessWidget {
  const ProfileStackDesign({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.26,
        ),
        Container(
          height: screenHeight * 0.2,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF50559a),
                  Color(0xFFd988a1),

                  //50559a
                ]),
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(
                    MediaQuery.of(context).size.width, 250.0)),
          ),
        ),
        Positioned(
          top: screenHeight * 0.11,
          left: screenHeight * 0.168,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 201, 200, 200),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 8)
              ],
            ),
            child: const CircleAvatar(
              backgroundColor: Color(0xFFfafafa),
              radius: 60,
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.11,
          left: screenHeight * 0.1699,
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_sharp,
                size: 100,
                color: Color(0xFFd988a1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
