// ignore_for_file: file_names
import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());

class Profile{
  //String id;
  String? name;
  int? age;
  //String? birthday;
  String? email;
  String? occupation;

  Profile({
    required this.name,
    required this.age,
    //required this.birthday,
    required this.email,
    required this.occupation,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json["name"],
    age: json["age"],
    occupation: json["occupation"],
    //birthday: json["birthday"],
    //gender: json["gender"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    //'id' : id,
    'name' : name,
    'age' : age,
    'occupation' : occupation,
    //'birthday' : birthday,
    'email' : email,
  };
}