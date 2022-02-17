import 'package:flapkap_flutter_challenge/controllers/data_controller.dart';
import 'package:flapkap_flutter_challenge/models/order.dart';
import 'package:flapkap_flutter_challenge/widgets/scroll_widget.dart';
import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<Order> _orders = [];
  int length = 0;
  double average = 0;
  int numberOfReturns = 0;
  final List<String> _colNames = [
    'Total Count',
    'Avergae Price',
    'Number Of Returns'
  ];
  List<String> _getCells() {
    return [
      length.toString(),
      average.toStringAsFixed(2),
      numberOfReturns.toString()
    ];
  }

  Future<List<Order>> getOrders() async {
    _orders = await DataController.getData();
    length = _orders.length;
    average = DataController.getAverage(_orders);
    numberOfReturns = DataController.getNumberOfReturns(_orders);
    return _orders;
  }

  // ignore: prefer_typing_uninitialized_variables
  var ordersFuture;
  @override
  void initState() {
    super.initState();
    ordersFuture = getOrders();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return ScrollWidget(
      child: SizedBox(
        width: mediaQuery.width,
        child: Row(
          children: [
            Expanded(
              child: FutureBuilder<List<Order>>(
                future: ordersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: DataTable(
                        columnSpacing: 45,
                          columns: _colNames
                              .map((e) => DataColumn(
                                    label: Text(e,overflow: TextOverflow.ellipsis,),
                                  ))
                              .toList(),
                          rows: [
                            DataRow(
                              cells: _getCells().map((e) => DataCell(Text(e))).toList(),
                            )
                          ]),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
