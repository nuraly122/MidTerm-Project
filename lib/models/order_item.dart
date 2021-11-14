import 'package:flutter/cupertino.dart';

import '../models/cart_item.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.dateTime,
    @required this.id,
    @required this.amount,
    @required this.products,
  });
}
