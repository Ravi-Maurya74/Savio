import 'package:flutter/material.dart';

class NewNavBarTab extends StatelessWidget {
  const NewNavBarTab({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('new screen rebuild');
    return const Center(
      child: Text('new screen'),
    );
  }
}
