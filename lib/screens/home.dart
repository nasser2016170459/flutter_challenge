import 'package:flapkap_flutter_challenge/screens/chart_screen.dart';
import 'package:flapkap_flutter_challenge/screens/table_screen.dart';
import 'package:flapkap_flutter_challenge/widgets/tabbar_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: TabBarWidget(
      title: 'FlapKap Challenge',
      tabs: [
        Tab(icon: Icon(Icons.table_chart_outlined), text: 'Data Table'),
        Tab(icon: Icon(Icons.select_all), text: 'Chart'),
      ],
      children: [
        TableScreen(),
        ChartScreen(),
      ],
    ));
  }
}
