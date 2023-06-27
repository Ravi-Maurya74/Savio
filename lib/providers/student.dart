import 'dart:convert';
import 'package:exp_man/services/networking.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Student with ChangeNotifier {
  int id = 0;
  String email = '';
  String name = '';
  List<dynamic> transactions = [];
  List<dynamic> budgets = [];
  double credit_score = 0.0;
  double total_budget = 0.0;
  double expense = 0.0;
  double savings = 0.0;
  String city = '';

  void update({required dynamic data}) {
    id = data['id'];
    email = data['email'];
    name = data['name'];
    transactions = data['transactions'];
    budgets = data['budgets'];
    credit_score = double.tryParse(data['credit_score'] as String)!;
    city = data['city'];
    total_budget = double.tryParse(data['total_budget'] as String)!;
    if (data['expense'] != null) {
      expense = double.tryParse(data['expense'].toString())!;
    }
    savings = total_budget - expense;
    notifyListeners();
  }

  void retrieveUpdatedData() async {
    Response response =
        await NetworkHelper().getData('student/retrieve/$email');
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      update(data: data);
    }
  }

  Future<bool> addTransaction(
      {required String title,
      required double? amount,
      required int category,
      required DateTime? date}) async {
    if (title.isEmpty || amount == null || amount < 0 || date == null) {
      return Future.value(false);
    }
    String formattedDate = DateFormat("yyyy-MM-dd").format(date);
    await NetworkHelper().postData(url: 'transaction/create/', jsonMap: {
      'title': title,
      'amount': amount,
      'category': category,
      'student': id,
      'date': formattedDate
    });
    Response response =
        await NetworkHelper().getData('student/retrieve/$email');
    dynamic data = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      update(data: data);
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  void deleteTransaction(int value) async {
    Response response = await NetworkHelper().deleteTransaction(value);
    if (response.statusCode == 204) {
      Response userData =
          await NetworkHelper().getData('student/retrieve/$email');
      if (userData.statusCode >= 200 && userData.statusCode < 300) {
        dynamic userDetail = jsonDecode(userData.body);
        update(data: userDetail);
        return;
      } else {
        print(response.statusCode);
      }
    }
  }
}
