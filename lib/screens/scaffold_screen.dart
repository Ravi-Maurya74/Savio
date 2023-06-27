import 'package:exp_man/screens/community_screen.dart';
import 'package:exp_man/screens/home_screen.dart';
import 'package:exp_man/screens/user_profile_screen.dart';
import 'package:exp_man/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:exp_man/screens/add_expense_screen.dart';

class ScaffoldScreen extends StatefulWidget {
  const ScaffoldScreen({super.key});

  @override
  State<ScaffoldScreen> createState() => _ScaffoldScreenState();
}

class _ScaffoldScreenState extends State<ScaffoldScreen> {
  int selectedIndex = 0;

  late List<Widget?> navigationPages;

  @override
  void initState() {
    navigationPages = [
      const HomeScreen(),
      const CommunityScreen(),
      AddExpenseScreen(
        onNewExpenseSave: () {
          setState(() {
            selectedIndex = 0;
          });
        },
      ),
      const WishlistScreen(),
      const UserProfile()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'Savio',
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 8),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              elevation: 100,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Community',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_rounded),
                  label: 'Add',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'Profile',
                ),
              ],
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
        ),
        body: navigationPages[selectedIndex],
      ),
    );
  }
}

// IconButton(
//               onPressed: () {
//                 showDialog(context: context, builder: ((context) => AlertDialog(
                  
//                 )));
//               },
//               icon: const Icon(Icons.notifications),
//             )