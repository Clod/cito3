import 'dart:convert';
import 'package:flutter/foundation.dart';

class MyJson {
  final String field1;
  final int field2;
  final bool field3;

  MyJson({required this.field1, required this.field2, required this.field3});

  Map<String, dynamic> toJson() {
    return {
      'field1': field1,
      'field2': field2,
      'field3': field3,
    };
  }
}

void main() {
  // Create a JSon object with three random fields
  MyJson myJson = MyJson(
    field1: 'Random String',
    field2: 123,
    field3: true,
  );

  // Convert the JSON object to a string
  String jsonString = jsonEncode(myJson.toJson());

  debugPrint(jsonString);
}