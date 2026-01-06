import 'package:flutter/material.dart';
import '../app_service.dart';
import '../module.dart';

class UpdateDataPage extends StatefulWidget {
  final NewModel person;

  const UpdateDataPage({super.key, required this.person});

  @override
  State<UpdateDataPage> createState() => _UpdateDataPageState();
}

class _UpdateDataPageState extends State<UpdateDataPage> {
  late TextEditingController nameCtrl;
  late TextEditingController ageCtrl;
  late TextEditingController cityCtrl;

  final AppService service = AppService();

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.person.name);
    ageCtrl  = TextEditingController(text: widget.person.age.toString());
    cityCtrl = TextEditingController(text: widget.person.city);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameCtrl.dispose();
    ageCtrl.dispose();
    cityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Data")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: ageCtrl, decoration: InputDecoration(labelText: "Age")),
            TextField(controller: cityCtrl, decoration: InputDecoration(labelText: "City")),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await service.update(
                  id: widget.person.id!,
                  name: nameCtrl.text,
                  age: ageCtrl.text,
                  city: cityCtrl.text,
                );

                Navigator.pop(context, true); // 👈 return success
              },
              child: Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
