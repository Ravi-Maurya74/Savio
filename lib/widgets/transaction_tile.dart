import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:exp_man/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:exp_man/providers/student.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

enum Category { food, travel, work, leisure }

class TransactionTileBuilder extends StatefulWidget {
  const TransactionTileBuilder({super.key});

  @override
  State<TransactionTileBuilder> createState() => _TransactionTileBuilderState();
}

class _TransactionTileBuilderState extends State<TransactionTileBuilder> {
  void newFunction(int value) {
    return;
  }

  @override
  Widget build(BuildContext context) {
    Student student = Provider.of<Student>(context);
    return ListView.builder(
      physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
      shrinkWrap: true,
      itemCount: student.transactions.length,
      itemBuilder: (context, index) {
        DateTime date = DateTime.parse(student.transactions[index]['date']);
        String newFormat = DateFormat.yMMMd().format(date);
        return Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${student.transactions[index]['title']}  ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                      //change icon color
                      padding: const EdgeInsets.all(0),
                      itemBuilder: ((context) => [
                            const PopupMenuItem(
                              padding: EdgeInsets.all(0),
                              height: 30,
                              value: 0,
                              child: Text('Modify'),
                            ),
                            const PopupMenuItem(
                              height: 30,
                              value: 1,
                              child: Text('Delete'),
                            ),
                          ]),
                      onSelected: (value) async {
                        if (value == 1) {
                          student.deleteTransaction(
                              student.transactions[index]['id']);
                        } else {
                          var result = await showTextInputDialog(
                              title: "Update Transaction",
                              barrierDismissible: true,
                              // style: AdaptiveStyle
                              context: context,
                              textFields: [
                                DialogTextField(
                                  hintText: "Transaction title",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    }
                                  },
                                ),
                                DialogTextField(
                                  hintText: "Transaction amount",
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    }
                                    var amount = double.tryParse(value);
                                    if (amount == null) {
                                      return "Only numeric input allowed.";
                                    }
                                  },
                                )
                              ]);
                          if (result == null) return;
                          Response response = await NetworkHelper().patchData(
                              url:
                                  'transaction/update/${student.transactions[index]['id']}',
                              jsonMap: {
                                "title": result[0],
                                "amount": result[1]
                              });
                          if (response.statusCode == 200) {
                            dynamic updatedTransaction =
                                jsonDecode(response.body);
                            setState(() {
                              student.transactions[index]['title'] =
                                  updatedTransaction['title'];
                              student.transactions[index]['amount'] =
                                  updatedTransaction['amount'];
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.more_vert,
                          size: 21,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('\$ ${student.transactions[index]['amount']}'),
                    const Spacer(),
                    Text(newFormat),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
// Text(
//                       '(${student.transactions[index]['category']})',
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     ),