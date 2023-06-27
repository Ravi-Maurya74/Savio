import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static String id = 'home';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 70.0,
            width: 170.0,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(), backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.routename);
              },
              child: const Text(
                'login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 60.0,
          ),
          SizedBox(
            height: 70.0,
            width: 170.0,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.pushNamed(context, RegisterPage.routeName);
              },
              child: const Text('Register',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ),
          SizedBox(
            height: 70.0,
            width: 170.0,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(), backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.routename);
              },
              child: const Text(
                'SignIn Google',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
