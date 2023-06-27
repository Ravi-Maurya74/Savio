import 'dart:convert';

import 'package:exp_man/providers/student.dart';
import 'package:exp_man/screens/scaffold_screen.dart';
import 'package:exp_man/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:exp_man/screens/home_screen.dart';
import 'package:exp_man/auth_and_login/login.dart';
import 'package:provider/provider.dart';
import 'package:exp_man/auth_and_login/google_signin.dart';

class LoadingScreen extends StatelessWidget {
  LoadingScreen({super.key});

  final user = FirebaseAuth.instance.currentUser;

  void isUser(BuildContext context) async {
    if (user != null) {
      Response response =
          await NetworkHelper().getData('student/retrieve/${user!.email}');
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        Provider.of<Student>(context, listen: false).update(data: data);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ScaffoldScreen(),
            ));
        // return Future.value(true);
      } else {
        Provider.of<GoogleSignInProvider>(context, listen: false)
            .googleLogout();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      }
      // student = Provider.of<Student>
      // return Future.value(false);
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // isUser(context);
    Future.delayed(Duration.zero, () async {
      isUser(context);
    });
    return Container(
      child: LoadingAnimationWidget.flickr(
          leftDotColor: const Color(0xFFd988a1).withOpacity(0.8),
          rightDotColor: const Color(0xFF50559a).withOpacity(0.8),
          size: 100),
    );
  }
}
