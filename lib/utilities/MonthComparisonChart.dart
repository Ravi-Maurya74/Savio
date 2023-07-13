import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChartData1> ChartData = [
      ChartData1(category: 'LEISURE', PreviousMonth: 1000, CurrentMonth: 2000),
      ChartData1(category: 'FOOD', PreviousMonth: 20000, CurrentMonth: 15000),
      ChartData1(category: 'TRAVEL', PreviousMonth: 2000, CurrentMonth: 1500),
      ChartData1(category: 'WORK', PreviousMonth: 1000, CurrentMonth: 2000)
    ];
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(top: 5, left: 2, right: 2, bottom: 1),
        margin: EdgeInsets.only(top: 5, left: 2, right: 2, bottom: 1),
        width: size.width * 0.8,
        height: size.height * 0.5,
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF50559a).withOpacity(0.4),
                const Color.fromARGB(255, 240, 139, 171).withOpacity(0.3),

                //50559a
              ]),
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              offset: Offset(0, 1),
              // color: Color.fromARGB(255, 194, 194, 194),
            ),
          ],
        ),
        child: SfCartesianChart(
            title: ChartTitle(
              text: 'Comparative Expenditure With Avg Expenditure',
              textStyle: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontFamily: "Alkatra", color: Colors.white),
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
            ),
            primaryXAxis: CategoryAxis(),
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              textStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontFamily: "Alkatra", color: Colors.white),
              position: LegendPosition.bottom,
              padding: 5,
            ),
            series: <ChartSeries>[
              StackedLineSeries<ChartData1, String>(
                  groupName: 'Previous Month',
                  legendItemText: 'Previous Month',
                  dataSource: ChartData,
                  xValueMapper: (ChartData1 data, _) => data.category,
                  yValueMapper: (ChartData1 data, _) => data.PreviousMonth),
              StackedLineSeries<ChartData1, String>(
                  groupName: 'Current Month',
                  legendItemText: 'Current Month',
                  dataSource: ChartData,
                  xValueMapper: (ChartData1 data, _) => data.category,
                  yValueMapper: (ChartData1 data, _) => data.CurrentMonth),
            ]));
  }
}

class ChartData1 {
  ChartData1(
      {required this.category,
      required this.PreviousMonth,
      required this.CurrentMonth});
  final String category;
  final int PreviousMonth;
  final int CurrentMonth;
}
