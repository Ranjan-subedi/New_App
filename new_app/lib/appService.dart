import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/module.dart';

class Appservice {
  String renderUrl = "https://new-app-qa04.onrender.com/about/add";
  Future<List<NewModel>> fetchData()async{
    try{
      final url = Uri.parse("$renderUrl/list");
      final response = await http.get(url);

      if(response.statusCode == 200){
        final List<dynamic> personList = jsonDecode(response.body);
        return personList.map((e) => NewModel(
            id: e["id"],
            name: e["name"],
            age: e["age"],
            city: e["city"]
        )).toList();

      }else{
        throw Exception("Failed to load data ${response.statusCode}");
      }

    }catch(e){
      debugPrint(e.toString());
      return [];
    }
  }


  Future<void> createData(NewModel data)async{
    try{
      final resData = await http.get(Uri.parse("https://new-app-qa04.onrender.com"));
      debugPrint(resData.body);
      final url = Uri.parse(renderUrl);
      final response =await http.post(url,
      headers: {"Content-Type" :"application/json" },
        body: jsonEncode(data.toJson())
      );

      debugPrint("your status code is : ${response.statusCode.toString()}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Data added successfully");
        debugPrint(response.body);
      } else {
        debugPrint("Failed to add data");
      }

    }catch(e)
    {debugPrint(e.toString());
    }
  }

  Future<void> addData({
    required String id,
    required String name,
    required String age,
    required String city,
  }) async {
    try {
      String webUrl = "http://localhost:3000/about/add";
      String emulatorurl = "http://10.0.2.2:3000/about/add";
      String renderUrl = "https://new-app-qa04.onrender.com/about/add";
      final url = Uri.parse(renderUrl);
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id" : id,
          "name": name,
          "age": age,
          "city": city
        }),
      );
      debugPrint("your status code is : ${response.statusCode.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
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
