import 'package:exp_man/providers/student.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    Future.delayed(Duration(seconds: 0));
    Student student = Provider.of<Student>(context, listen: false);
    for (var i in student.transactions) {
      upDateChart(i);
    }
    chartData = GetChartData();
    print('1');
  }

  void upDateChart(var i) {
    print(i['category']);
    if (i['category'] == 'Food')
      Food += i['amount'];
    else if (i['category'] == 'Travel')
      Travel += i['amount'];
    else if (i['category'] == 'Work')
      Work += i['amount'];
    else
      Leisure += i['amount'];
  }

  List<ChartData> GetChartData() {
    return [
      ChartData('LEISURE', Leisure.toDouble()),
      ChartData('FOOD', Food.toDouble()),
      ChartData('WORK', Work.toDouble()),
      ChartData('TRAVEL', Travel.toDouble())
    ];
  }

  List<ChartData> chartData = [];
  num Leisure = 0;
  num Food = 0;
  num Work = 0;
  num Travel = 0;
  @override
  Widget build(BuildContext context) {
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
              dataLabelSettings: DataLabelSettings(isVisible: true),
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
