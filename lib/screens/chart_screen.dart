import 'package:flapkap_flutter_challenge/controllers/data_controller.dart';
import 'package:flapkap_flutter_challenge/models/order.dart';
import 'package:flapkap_flutter_challenge/models/sales_info.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<Order> _orders = [];
  final List<SalesInfo> _sales = [];
  final Map<String, int> _salesMap = {};

  Future<List<SalesInfo>> getSales() async {
    _orders = await DataController.getData();
   // adjustDataOldMethod();
    adjustDataNewMethod();
    return _sales;
  }

  void adjustDataNewMethod() {
    for (int i = 0; i < _orders.length; i++) {
      Order order = _orders[i];
      if (!_salesMap.containsKey(order.registered)) {
        _salesMap[order.registered] = 1;
      } else {
        _salesMap.update(order.registered, (value) {
          return value += 1;
        });
      }
    }
  }

  // void adjustDataOldMethod() {
  //   for (int i = 0; i < _orders.length; i++) {
  //     Order order = _orders[i];
  //     SalesInfo sale = SalesInfo(date: order.registered, numberOfSales: 1);
  //     for (int j = 0; j < _orders.length; j++) {
  //       if (i != j) {
  //         if (_orders[j].registered == order.registered) {
  //           sale.numberOfSales += 1;
  //         }
  //       }
  //     }
  //     _sales.add(sale);
  //   }
  // }

  // ignore: prefer_typing_uninitialized_variables
  var salesFuture;
  @override
  void initState() {
    super.initState();
    salesFuture = getSales();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SalesInfo>>(
        future: salesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              padding: const EdgeInsets.only(top: 20, right: 25, left: 0),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(text: 'Time (Date)'),
                  desiredIntervals: 1,
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Number of sales'),
                  decimalPlaces: 0,
                  interval: 1,
                ),
                title: ChartTitle(text: 'Sales Analysis'),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <LineSeries<SalesInfo, String>>[
                  LineSeries<SalesInfo, String>(
                    dataSource: _salesMap.entries
                        .map((e) =>
                            SalesInfo(date: e.key, numberOfSales: e.value))
                        .toList(),
                    xValueMapper: (SalesInfo sale, _) => sale.date,
                    yValueMapper: (SalesInfo sale, _) => sale.numberOfSales,
                    name: 'Sales',
                  )
                ],
              ),
            );
          }
        });
  }
}
