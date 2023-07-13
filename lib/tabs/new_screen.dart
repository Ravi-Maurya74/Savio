import 'package:exp_man/screens/your_savings_screen.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:exp_man/utilities/RadialBarChart.dart';
import 'package:exp_man/utilities/MonthComparisonChart.dart';

class inDepthVisualization extends StatelessWidget {
  const inDepthVisualization({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> charts = [RadialChart(), MyWidget(), RadialChart()];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Swiper(
                containerWidth: size.width * 0.8,
                containerHeight: size.height * 0.5,
                pagination: SwiperPagination(),
                itemCount: 3,
                itemBuilder: (context, index) => charts[index],
              ),
            ),
            Container(
              height: size.height * 0.3,
            )
          ],
        ),
      )),
    );
  }
}
