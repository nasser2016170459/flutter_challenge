class Order {
  final String id;
  final bool isActive;
  final String company;
  final String picture;
  final String buyer;
  final String status;
  String price;
  String registered;
  final List<String> tags;
  Order({
    required this.buyer,
    required this.company,
    required this.price,
    required this.id,
    required this.isActive,
    required this.picture,
    required this.registered,
    required this.status,
    required this.tags,
  });

  static List<Order> _orders = [];

  static List<Order> fromJson(List<dynamic> json) {
    _orders = [];
    for (int i = 0; i < json.length; i++) {
      _orders.add(Order(
        buyer: json[i]['buyer'],
        company: json[i]['company'],
        price: json[i]['price'],
        id: json[i]['id'],
        isActive: json[i]['isActive'],
        picture: json[i]['picture'],
        registered: json[i]['registered'],
        status: json[i]['status'],
        tags: (json[i]['tags']).cast<String>(),
      ));
    }
    return _orders;
  }
}
