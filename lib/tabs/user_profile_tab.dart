import 'package:exp_man/auth_and_login/google_signin.dart';
import 'package:exp_man/auth_and_login/login.dart';
import 'package:exp_man/screens/edit_profile_screen.dart';
import 'package:exp_man/screens/your_savings_screen.dart';
import 'package:exp_man/utilities/profile_stack_design.dart';
import 'package:exp_man/widgets/user_detail_tile.dart';
import 'package:flutter/material.dart';
import 'package:exp_man/providers/student.dart';
import 'package:provider/provider.dart';

class UserProfileTab extends StatefulWidget {
  const UserProfileTab({super.key});

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {
  @override
  Widget build(BuildContext context) {
    debugPrint('profile rebuild');
    Student student = Provider.of<Student>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ProfileStackDesign(),
          Text(
            student.name,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(student.email, style: Theme.of(context).textTheme.bodyMedium!),
          const SizedBox(
            height: 25,
          ),
          Column(
            children: [
              UserdetailTile(
                Icons.account_circle_outlined,
                titleDescription: 'Edit your profile name and city',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'User profile',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const EditProfileScreen(
                              title: 'Edit User Profile'))));
                },
              ),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              // UserdetailTile(
              //   Icons.account_balance_wallet_outlined,
              //   titleDescription: 'View your total and category budgets',
              //   trailingIcon: Icons.chevron_right_outlined,
              //   title: 'Budget',
              //   onPress: () {},
              // ),
              // const Divider(
              //   thickness: 0.5,
              //   indent: 20,
              //   endIndent: 20,
              // ),
              UserdetailTile(
                Icons.bookmark_outline,
                titleDescription: 'See all the saved posts from community',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'Saved posts',
                onPress: () {},
              ),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              UserdetailTile(
                Icons.account_balance_outlined,
                titleDescription: 'See your monthly savings',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'Savings',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const SavingsScreen())));
                },
              ),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              UserdetailTile(
                Icons.forum_outlined,
                titleDescription: 'View all your posts',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'My posts',
                onPress: () {},
              ),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              UserdetailTile(
                Icons.power_settings_new,
                titleDescription: 'Log out your profile',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'Log Out',
                onPress: () async {
                  await Provider.of<GoogleSignInProvider>(context,
                          listen: false)
                      .googleLogout();
                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginPage.routename, (route) => false);
                },
              ),
              // const SizedBox(
              //   height: 150,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}


// Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _titleController,
//                   decoration: const InputDecoration(
//                     label: Text('Title'),
//                   ),
//                 ),
//                 // const SizedBox(height: 16),
//                 // TextField(
//                 //   controller: _emailController,
//                 //   keyboardType: TextInputType.emailAddress,
//                 //   decoration: const InputDecoration(
//                 //     label: Text('Email'),
//                 //   ),
//                 // ),
//                 const SizedBox(height: 16),
//                 TextField(
//                   controller: _cityController,
//                   decoration: const InputDecoration(
//                     label: Text('City'),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _totalBudgetController,
//                         keyboardType: TextInputType.number,
//                         decoration: const InputDecoration(
//                           label: Text('Total Budget'),
//                           prefixText: '\$ ',
//                         ),
//                       ),
//                     ),
//                     const Spacer(),
//                     // const SizedBox(
//                     //   width: 40,
//                     // ),
//                     ElevatedButton(
//                         onPressed: () {}, child: const Text('Save Edit')),
//                     // Expanded(
//                     //   child: TextField(
//                     //     controller: _categoryBudgetController,
//                     //     keyboardType: TextInputType.number,
//                     //     decoration: const InputDecoration(
//                     //       label: Text('Category Budget'),
//                     //       prefixText: '\$ ',
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 // const SizedBox(height: 32),
//                 // ElevatedButton(
//                 //     onPressed: () {}, child: const Text('Save Edit')),
//               ],
//             ),
//           ),