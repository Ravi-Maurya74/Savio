import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class ChartData {
  ChartData(this.category, this.amount);
  final String category;
  final double amount;
}

class RadialChart extends StatefulWidget {
  const RadialChart({super.key});

  @override
  State<RadialChart> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RadialChart> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('LEISURE', 3500),
      ChartData('FOOD', 7200),
      ChartData('WORK', 10500),
      ChartData('TRAVEL', 5000)
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
        child: SfCircularChart(
          title: ChartTitle(
            text: 'Category wise expenditure',
            textStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontFamily: "Alkatra", color: Colors.white),
          ),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CircularSeries<ChartData, String>>[
            RadialBarSeries<ChartData, String>(
              // explode: true,
              // explodeIndex: 0,
              maximumValue: 25000,
              radius: '100%',
              dataSource: chartData,
              cornerStyle: CornerStyle.bothFlat,
              enableTooltip: true,
              dataLabelSettings: const DataLabelSettings(),
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.amount,
            )
          ],
          legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
            textStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontFamily: "Alkatra", color: Colors.white),
            position: LegendPosition.right,
            padding: 5,
          ),
        ));
  }
}
