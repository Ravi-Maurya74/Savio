import 'dart:convert';
import 'package:exp_man/services/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'login.dart';
import '../utilities/custom_textfield.dart';
import '../utilities/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exp_man/providers/student.dart';
import 'package:provider/provider.dart';
import 'package:exp_man/screens/scaffold_screen.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = '/register';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  RegisterPage({super.key});

  final APIModel apiModel = APIModel();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    debugPrint(user.email);
    var dimensions = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Text('Create new account',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(
                height: 10,
              ),
              const Text('Please fill in the form to continue'),
              const SizedBox(height: 70),
              CustomTextField(
                label: 'Full Name',
                iconData: Icons.person,
                textEditingController: nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: 'City',
                iconData: Icons.location_history,
                textEditingController: cityController,
              ),
              const SizedBox(
                height: 70,
              ),
              CustomButton(
                  dimensions: dimensions,
                  label: 'Sign Up',
                  action: () async {
                    Response newUserData = await apiModel.createUser(
                        nameController.text, user.email!, cityController.text);
                    if (newUserData.statusCode >= 200) {
                      dynamic newUserDetail = jsonDecode(newUserData.body);
                      Student student =
                          Provider.of<Student>(context, listen: false);
                      student.update(data: newUserDetail);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const ScaffoldScreen())));
                    } else {
                      //use snackbar to tell that email entered already exists
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Have an Account? ",
                    style: TextStyle(),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pushReplacementNamed(
                          context, LoginPage.routename);
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
