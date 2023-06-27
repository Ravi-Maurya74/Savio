import 'package:flutter/material.dart';
import 'package:exp_man/auth_and_login/google_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoggedIn extends StatelessWidget {
  const LoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogout();
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Text('Profile', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(
                height: 20.0,
              ),
              CircleAvatar(
                radius: 40.0,
                backgroundImage: NetworkImage(user!.photoURL.toString()),
              ),
              Text(
                'Name: ${user.displayName}',
              ),
              Text(
                'Email: ${user.email}',
              )
            ],
          )),
        ));
  }
}
