import 'dart:convert';

import 'package:exp_man/services/networking.dart';
import 'package:exp_man/widgets/custom_appbar.dart';
import 'package:exp_man/widgets/user_detail_tile.dart';
import 'package:flutter/material.dart';
import 'package:exp_man/providers/student.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    Student student = Provider.of<Student>(context);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: CustomAppbar(
              title: title,
            ),
          ),
          const SizedBox(height: 16),
          UserdetailTile(
            Icons.chevron_right_outlined,
            titleDescription: student.name,
            trailingIcon: Icons.create,
            title: 'Name',
            onPress: () async {
              var result = await showTextInputDialog(
                  title: "Update Student Name",
                  barrierDismissible: true,
                  // style: AdaptiveStyle
                  context: context,
                  textFields: [
                    DialogTextField(
                      hintText: "Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                    ),
                  ]);
              if (result == null) return;
              Response response = await NetworkHelper().patchData(
                  url: 'student/update/${student.id}',
                  jsonMap: {"name": result[0]});
              if (response.statusCode == 200) {
                dynamic data = jsonDecode(response.body);
                student.update(data: data);
              }
            },
          ),
          const Divider(
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
          UserdetailTile(
            Icons.chevron_right_outlined,
            titleDescription: student.city,
            trailingIcon: Icons.create,
            title: 'City',
            onPress: () async {
              var result = await showTextInputDialog(
                  title: "Update City",
                  barrierDismissible: true,
                  // style: AdaptiveStyle
                  context: context,
                  textFields: [
                    DialogTextField(
                      hintText: "City",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                    ),
                  ]);
              if (result == null) return;
              Response response = await NetworkHelper().patchData(
                  url: 'student/update/${student.id}',
                  jsonMap: {"city": result[0]});
              if (response.statusCode == 200) {
                dynamic data = jsonDecode(response.body);
                student.update(data: data);
              }
            },
          ),
          const Divider(
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
          UserdetailTile(
            Icons.chevron_right_outlined,
            titleDescription: '${student.total_budget}',
            trailingIcon: Icons.create,
            title: 'Total budget',
            onPress: () async {
              var result = await showTextInputDialog(
                  title: "Update Total Budget",
                  barrierDismissible: true,
                  // style: AdaptiveStyle
                  context: context,
                  textFields: [
                    DialogTextField(
                      hintText: "TotalBudget",
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        var budget = double.tryParse(value);
                        if (budget == null) {
                          return "Only numeric input allowed";
                        }
                        return null;
                      },
                    ),
                  ]);
              if (result == null) return;
              Response response = await NetworkHelper().patchData(
                  url: 'student/update/${student.id}',
                  jsonMap: {"total_budget": result[0]});
              if (response.statusCode == 200) {
                dynamic data = jsonDecode(response.body);
                student.update(data: data);
              }
            },
          ),
          const Divider(
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
        ],
      )),
    );
  }
}
