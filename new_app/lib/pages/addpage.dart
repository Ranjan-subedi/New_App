import 'package:flutter/material.dart';
import 'package:new_app/app_service.dart';
import 'package:uuid/uuid.dart';

import '../module.dart';

class CreateDataPage extends StatefulWidget {
  const CreateDataPage({super.key});

  @override
  State<CreateDataPage> createState() => _CreateDataPageState();
}

class _CreateDataPageState extends State<CreateDataPage> {

  AppService appService = AppService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async {
            final uuid = Uuid();

            final newData = NewModel(
                id: uuid.v1(),
                name: nameController.text,
                age: ageController.text,
                city: cityController.text);

            await appService.createData(newData);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Data added successfully")),
            );
          }, icon: Icon(Icons.save_alt))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32
        ),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  )
                ),
                labelText: "Name",
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    )
                ),
                labelText: "age",
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: cityController,

              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    )
                ),
                labelText: "city",
              ),
            ),
            SizedBox(height: 20,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xFF9248E8),
                  foregroundColor: Colors.white70
              ),
              onPressed: () async {
                final uuid = Uuid();

                final newData = NewModel(
                    id: uuid.v1(),
                    name: nameController.text,
                    age: ageController.text,
                    city: cityController.text);

                await appService.createData(newData);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Data added successfully")),
                );
                Navigator.pop(context);

              },
              child:  Text("Add Data",
                style: TextStyle(
                fontSize: 18,),),
            ),
          ],
        ),
      ),
    );
  }
}
