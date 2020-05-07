// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromMap(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toMap());

class Customer {
  int customerId;
  String name;

  Customer({
    this.customerId,
    this.name,
  });

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        customerId: json["customer_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "customer_id": customerId,
        "name": name,
      };
}
