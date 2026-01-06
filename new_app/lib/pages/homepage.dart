import 'package:flutter/material.dart';
import 'package:new_app/pages/addpage.dart';
import 'package:new_app/pages/update.dart';
import 'package:uuid/uuid.dart';

import '../app_service.dart';
import '../module.dart';



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
      backgroundColor: Color(0xce695555),
      appBar: AppBar(
        backgroundColor: Color(0xFF9248E8),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          refreshData();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Container(
                  color: Color(0xFF6148E8),
                  height: MediaQuery.sizeOf(context).height-177,
                  width: MediaQuery.sizeOf(context).width,
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
                              elevation: 5,
                              child: ListTile(
                                trailing: dlt(person),
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

              // From HomePage

              // TextField(
              //   controller: nameController,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: "Name",
              //   ),
              // ),
              // TextField(
              //   controller: ageController,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: "age",
              //   ),
              // ),
              // TextField(
              //   controller: cityController,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: "city",
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color(0xFF9248E8),
                          foregroundColor: Colors.white70
                        ),
                        onPressed: () async {

                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CreateDataPage(),));

                          // final uuid = Uuid();
                          //
                          // final newData = NewModel(
                          //     id: uuid.v1(),
                          //     name: nameController.text,
                          //     age: ageController.text,
                          //     city: cityController.text);
                          //
                          // await appservice.createData(newData);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text("Data added successfully")),
                          // );
                          // refreshData();

                        },
                        child: Text("Add Data", style: TextStyle(
                          fontSize: 18,

                        ),),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Color(0xFF9248E8),
                            foregroundColor: Colors.white70
                        ),
                        onPressed: () {
                          refreshData();
                        },
                        child: Text("Refresh Data", style: TextStyle(fontSize: 18),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget dlt (NewModel person){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: () async{
          await appservice.delete(person.id!);
          refreshData();
        }, icon: Icon(Icons.delete, color:Color(0xFF9248E8), size: 28,)),

        IconButton(onPressed: () async{
          final result = await Navigator.push(context, MaterialPageRoute(builder:
              (context) =>
                  UpdateDataPage(person: person,),),);

          if(result == true){
            refreshData();
          }
        }, icon: Icon(Icons.update, color: Color(0xFF9248E8),size: 28,)),
      ],
    );
  }

}
