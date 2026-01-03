class NewModel {
  final String? id;
  final String? name;
  final String? age;
  final String? city;

  const NewModel({
    required this.id,
    required this.name,
    required this.age,
    required this.city
  });


  // from json to map
  factory NewModel.fromJson(Map<String,dynamic> json){
    return NewModel(
    id : json["id"] as String,
    name : json["name"] as String,
    age : json["age"] as String,
    city : json["city"] as String
    );
  }

  //from map Flutter to json
Map<String,dynamic> toJson(){
    return {
      "id" : id,
      "name" : name,
      "age" : age,
      "city" : city,
    };
}

}
