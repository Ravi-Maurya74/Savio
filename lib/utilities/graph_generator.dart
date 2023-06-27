import 'dart:convert';

import 'package:exp_man/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart';

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
    initialise();
  }

  void initialise() async {
    Response response =
        await NetworkHelper().getData('student/monthlyExpenses/${widget.id}');
    dynamic data = jsonDecode(response.body);
    data.forEach((key, value) {
      chartData.add(_ChartData(DateTime.parse(key), value));
    });
    setState(() {
      chartData;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 8),
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
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(),
          series: <ChartSeries>[
            LineSeries<_ChartData, DateTime>(
              isVisibleInLegend: true,
              color: Color.fromARGB(255, 5, 118, 138),
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
