import 'dart:convert';

import 'package:exp_man/providers/scrollcontroller.dart';
import 'package:exp_man/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart';

import '../providers/student.dart';

class GraphGenerator extends StatefulWidget {
  const GraphGenerator({super.key, required this.id});

  final int id;

  @override
  State<GraphGenerator> createState() => _GraphGeneratorState();
}

class _GraphGeneratorState extends State<GraphGenerator> {
  List<_ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
    addChartData();
  }

  Future<List<_ChartData>> getChartData() async {
    Response response =
        await NetworkHelper().getData('student/monthlyExpenses/${widget.id}');
    dynamic data = jsonDecode(response.body);
    List<_ChartData> newData = [];
    data.forEach((key, value) {
      newData.add(_ChartData(DateTime.parse(key), value));
    });
    return newData;
  }

  void addChartData() async {
    var newData = await getChartData();
    setState(() {
      chartData = newData;
    });
  }

  @override
  void didUpdateWidget(covariant GraphGenerator oldWidget) {
    super.didUpdateWidget(oldWidget);
    addChartData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 1),
      padding: const EdgeInsets.only(top: 6, right: 4, left: 2),
      width: double.infinity,
      height: size.width * 0.61,
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 2, 4),
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(),
          enableAxisAnimation: true,
          tooltipBehavior: TooltipBehavior(
            builder: (data, point, series, pointIndex, seriesIndex)  {
              Provider.of<ScrollControllerProvider>(context,listen: false).scrollToWidget((data as _ChartData).date,Provider.of<Student>(context,listen: false).transactions);
              return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "${DateFormat("d MMM").format((data).date)}: ₹${data.expense.toString()}",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black),
              ),
            );},
            enable: true,
          ),
          isTransposed: true,
          series: <ChartSeries>[
            BarSeries<_ChartData, DateTime>(
              isVisibleInLegend: true,
              color:
                  const Color.fromARGB(255, 110, 152, 174).withOpacity(0.8), //
              dataSource: chartData,
              xValueMapper: (data, _) => data.date,
              yValueMapper: (data, _) => data.expense,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  final DateTime date;
  final double expense;

  _ChartData(this.date, this.expense);
}
