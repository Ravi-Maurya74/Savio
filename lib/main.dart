import 'package:exp_man/providers/community_post.dart';
import 'package:exp_man/screens/blogscreen.dart';
import 'package:exp_man/screens/scaffold_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:exp_man/auth_and_login/google_signin.dart';
import 'package:exp_man/providers/student.dart';
import 'package:exp_man/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_and_login/signup.dart';
import 'auth_and_login/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) => GoogleSignInProvider())),
          ChangeNotifierProvider(create: ((context) => Student()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            // dialogBackgroundColor: const Color.fromRGBO(37, 42, 52, 1),
            scaffoldBackgroundColor: const Color.fromRGBO(24, 25, 32, 1),
            primaryColor: const Color(0xFF21212f),
            appBarTheme: const AppBarTheme(
              color: Color.fromRGBO(24, 25, 32, 1),
              shadowColor: Colors.black87, // Change the AppBar color
              elevation: 8,
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color.fromARGB(
                  255, 114, 122, 226), // Set the desired cursor color
            ),
            inputDecorationTheme: const InputDecorationTheme(
              // labelStyle: TextStyle(
              //   color: Color.fromARGB(
              //       255, 114, 122, 226), // Set the desired label color
              // ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 114, 122, 226),
                ), // Set the desired underline color for active text fields
              ),
            ),
            dialogTheme: DialogTheme(
              backgroundColor: const Color.fromRGBO(
                  37, 42, 52, 1), //Color.fromARGB(255, 114, 122, 226),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    20.0), // Set the desired border radius here
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedIconTheme: IconThemeData(
                color: Color(0xFFd988a1),
              ),
              selectedItemColor: Color(0xFFd988a1),
              backgroundColor: Color.fromRGBO(24, 25, 32, 1),
              elevation: 20,
            ),
            cardTheme: CardTheme(
              color: const Color.fromRGBO(37, 42, 52, 1),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            textTheme: GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme),
            iconTheme: const IconThemeData(
              color: Color(0xFFd988a1),
            ),
          ),
          routes: {
            '/': (context) => LoadingScreen(),
            LoginPage.routename: (context) => const LoginPage(),
            RegisterPage.routeName: (context) => RegisterPage(),
            ScaffoldScreen.routename: (context) => const ScaffoldScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == BlogScreen.routeName) {
              return MaterialPageRoute(
                builder: (context) {
                  return ChangeNotifierProvider.value(
                    value: settings.arguments as CommunityPost,
                    // create: (context) => settings.arguments as CommunityPost,
                    child: const BlogScreen(),
                  );
                },
              );
            }
            return null;
          },
        ),
      );
}
//#d988a1    #1b1a25   #21212f    #50559a    #2f3743   #b785b5