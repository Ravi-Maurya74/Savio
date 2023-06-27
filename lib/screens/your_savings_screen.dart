import 'package:flutter/material.dart';
import 'package:exp_man/widgets/custom_appbar.dart';
import 'package:exp_man/providers/student.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Student student = Provider.of<Student>(context);
    double expenseExceedBy = student.expense - student.total_budget;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: CustomAppbar(
              title: 'Savings',
            ),
          ),
          const SizedBox(height: 90),
          student.savings < 0
              ? Text(
                  '\$ 0',
                  style: Theme.of(context).textTheme.displaySmall,
                )
              : Text(
                  '\$ ${student.savings.toString()}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
          const SizedBox(height: 10),
          Text(
            'Your monthly saving',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Container(
            height: 400,
            width: 400,
            child: student.savings < 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your total monthly expense exceeds your budget by-',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        '\$ $expenseExceedBy',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  )
                : SfCircularChart(
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap,
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontFamily: "Alkatra", color: Colors.white),
                      position: LegendPosition.bottom,
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CircularSeries>[
                      PieSeries<ChartData, String>(
                        explode: true,
                        explodeIndex: 0,
                        explodeOffset: '10%',
                        dataSource: [
                          ChartData('Savings', student.savings),
                          ChartData('Expense', student.expense),
                        ],
                        xValueMapper: (ChartData data, _) => data.category,
                        yValueMapper: (ChartData data, _) => data.amount,
                        dataLabelSettings: const DataLabelSettings(),
                        enableTooltip: true,
                      )
                    ],
                  ),
          ),
        ],
      ),
    ));
  }
}

class ChartData {
  ChartData(this.category, this.amount);
  final String category;
  final double amount;
}
