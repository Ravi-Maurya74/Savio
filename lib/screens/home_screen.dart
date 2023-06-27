import 'package:exp_man/utilities/circular_icon_card.dart';
import 'package:flutter/material.dart';
import 'package:exp_man/utilities/graph_generator.dart';
import 'package:exp_man/widgets/transaction_tile.dart';
import 'package:exp_man/providers/student.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Student student = Provider.of<Student>(
        context); //listen ko false na dene se stl widget hote hue bhi build har baar run hoga jab jab provider value change hoga
    Size size = MediaQuery.of(context).size;

    double expenseExceedBy = student.expense - student.total_budget;
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
              ),
              // Center(
              //   child: Row(
              //     children: [
              //       const Expanded(
              //           child: Divider(
              //         thickness: 0.9,
              //         indent: 5,
              //         endIndent: 10,
              //       )),
              //       Text(
              //         'Your Spending Pattern',
              //         style: Theme.of(context)
              //             .textTheme
              //             .titleLarge!
              //             .copyWith(color: Colors.white70),
              //       ),
              //       const Expanded(
              //           child: Divider(
              //         thickness: 0.9,
              //         indent: 10,
              //         endIndent: 5,
              //       )),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 6,
              // ),
              GraphGenerator(
                id: student.id,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  elongatedContainer(size, student, context),
                  CircularIconCard(
                    alertIcon: Icons.credit_score,
                    onPress: () {
                      showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: const Text('Credit score'),
                              content: const Text(
                                  'Aaj tak kisi ne credit diya bhi hai!\naya bada credit score dekhne'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('okay')),
                              ],
                            )),
                      );
                    },
                  ),
                  CircularIconCard(
                    alertIcon: student.savings < 0
                        ? Icons.notifications_active_outlined
                        : Icons.notifications_outlined,
                    onPress: () {
                      student.savings < 0
                          ? showDialog(
                              context: context,
                              builder: ((context) => AlertDialog(
                                    title: const Text('Budget Exceeded'),
                                    content: Text(
                                        'Your total monthly expenses has crossed your monthly budget by \$$expenseExceedBy'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('okay')),
                                    ],
                                  )),
                            )
                          : showDialog(
                              context: context,
                              builder: ((context) => AlertDialog(
                                    title: const Text('Within Budget'),
                                    content: const Text(
                                        'Your total monthly expenses has not crossed your monthly budget'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('okay')),
                                    ],
                                  )),
                            );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Center(
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 0.9,
                        indent: 5,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      'Your Transactions',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white70, fontWeight: FontWeight.w400),
                    ),
                    const Expanded(
                        child: Divider(
                      thickness: 0.9,
                      indent: 10,
                      endIndent: 5,
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const TransactionTileBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded elongatedContainer(
      Size size, Student student, BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(left: 5, right: 5, bottom: 8, top: 8),
          height: size.width * 0.15,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF50559a).withOpacity(0.7),
                  const Color(0xFFd988a1).withOpacity(0.7),

                  //50559a
                ]),
            // color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                offset: Offset(0, 1),
                // color: Color.fromARGB(255, 194, 194, 194),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Total monthly budget:   \$ ${student.total_budget}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
