import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Appservice {
  Future<void> addData({
    required String id,
    required String name,
    required String age,
    required String city,
  }) async {
    try {
      String webUrl = "http://localhost:3000/about/add";
      String emulatorurl = "http://10.0.2.2:3000/about/add";
      final url = Uri.parse(emulatorurl);
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "age": age, "city": city}),
      );
      if (response.statusCode == 200) {
        debugPrint("Data added successfully");
        debugPrint(response.body);
      } else {
        debugPrint("Failed to add data");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
