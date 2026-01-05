import 'package:flutter/material.dart';
import 'package:new_app/app_service.dart';
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
  final AppService appservice = AppService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  late Future<List<NewModel>> futureData;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureData=appservice.fetchData();
    refreshData();
  }

  void refreshData(){
    setState(() {
      futureData  = appservice.fetchData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async{
          await refreshData ;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Container(
                  height: 400,
                  child: FutureBuilder<List<NewModel>>(
                    future: futureData ,
                    builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }else if (snapshot.hasError){
                      return Text('Error : ${snapshot.hasError}');
                    }else if(!snapshot.hasData || snapshot.data!.isEmpty){
                      return Text('No Data Found');
                    }else{
                      final personList = snapshot.data!;
                      return ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: personList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final person = personList[index];
                        return  Card(
                          child: ListTile(
                            trailing: dlt(person.id!),
                            title: Text(person.name ?? ""),
                            subtitle: Text("Age : ${person.age} , City : ${person.city}"),
                          ),
                        );
                      },);
                    }
                  },),
                ),
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
                  refreshData();

                },
                child: Icon(Icons.add),
              ),
              ElevatedButton(onPressed: () {

              }, child: Icon(Icons.delete)),
              ElevatedButton(
                onPressed: () {
                  refreshData();
                },
                child: Icon(Icons.read_more_outlined),
              ),
              ElevatedButton(onPressed: () {}, child: Icon(Icons.update)),
            ],
          ),
        ),
      ),
    );
  }
  Widget dlt (String id){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: () async{
          await appservice.delete(id);
          refreshData();
        }, icon: Icon(Icons.delete)),

        IconButton(onPressed: () {
        }, icon: Icon(Icons.update)),
  ],
      );
}
}
