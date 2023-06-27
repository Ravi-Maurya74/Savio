import 'dart:convert';
import 'package:exp_man/auth_and_login/google_signin.dart';
import 'package:exp_man/providers/student.dart';
import 'package:exp_man/screens/scaffold_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exp_man/services/networking.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import '../utilities/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';

class LoginPage extends StatelessWidget {
  static const routename = '/login';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final box = GetStorage();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var dimensions = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<Object?>(
          stream: (FirebaseAuth.instance.authStateChanges()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something Went Wrong!'));
            }
            // else if (snapshot.hasData) {
            //   return RegisterPage();
            // }
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(36.0),
                      height: 600.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/2.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: dimensions.height * 0.01,
                    ),
                    // Text('Welcome !',
                    //     style: Theme.of(context).textTheme.titleLarge),

                    CustomButton(
                      dimensions: dimensions,
                      label: 'Sign In with Google',
                      action: () async {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        await provider.googleLogin();
                        final user = FirebaseAuth.instance.currentUser;
                        debugPrint(user!.email);
                        Response userData = await NetworkHelper()
                            .getData('student/retrieve/${user.email}');
                        if (userData.statusCode >= 200 &&
                            userData.statusCode < 300) {
                          //user found
                          // if (mounted!) return;
                          dynamic userDetail = jsonDecode(userData.body);
                          Provider.of<Student>(context, listen: false)
                              .update(data: userDetail);
                          // print(student.name);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const ScaffoldScreen())));
                        } else if (userData.statusCode == 404) {
                          //user not found
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => RegisterPage())));
                        }
                      },
                    ),

                    SizedBox(
                      height: dimensions.height * 0.08,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
