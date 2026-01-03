import 'package:flutter/material.dart';
import 'package:new_app/appService.dart';
import 'package:new_app/module.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Appservice appservice = Appservice();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: ,
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name",
              ),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "age",
              ),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "city",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final uuid = Uuid();

                final newData = NewModel(
                    id: uuid.v1(),
                    name: nameController.text,
                    age: ageController.text,
                    city: cityController.text);

                await appservice.createData(newData);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Data added successfully")),
                );

              },
              child: Icon(Icons.add),
            ),
            ElevatedButton(onPressed: () {

            }, child: Icon(Icons.delete)),
            ElevatedButton(
              onPressed: () {},
              child: Icon(Icons.read_more_outlined),
            ),
            ElevatedButton(onPressed: () {}, child: Icon(Icons.update)),
          ],
        ),
      ),
    );
  }
}
