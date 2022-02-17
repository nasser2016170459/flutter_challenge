import 'dart:convert';

import 'package:flapkap_flutter_challenge/models/order.dart';
import 'package:flutter/services.dart';

class DataController {
  static String _data = '';
  static Future<List<Order>> getData() async {
    if (_data == '') {
      _data =
          await rootBundle.loadString('assets/json/orders.json', cache: false);
    }
    var decodedData = jsonDecode(_data);
    List<Order> _orders = Order.fromJson(decodedData);
    for (var element in _orders) {
      element.price = removeSpecialCharacters(element.price);
      element.registered = adjustDate(element.registered);
    }
    _orders.sort((a, b) => a.registered.compareTo(b.registered));
    return _orders;
  }

  static double getAverage(List<Order> orders) {
    double total = 0;
    double average = 0;
    if (orders.isNotEmpty) {
      for (var element in orders) {
        total += double.parse(element.price);
      }
      average = total / orders.length;
    }
    return average;
  }

  static String adjustDate(String date) {
    return date.substring(0, 10);
  }

  static int getNumberOfReturns(List<Order> orders) {
    int returnsCounter = 0;
    for (var element in orders) {
      if (element.status.trim().toLowerCase() == 'returned') {
        returnsCounter += 1;
      }
    }
    return returnsCounter;
  }

  static String removeSpecialCharacters(String price) {
    price = price.replaceAll("\$", "");
    price = price.replaceAll(",", "");
    return price;
  }
}
