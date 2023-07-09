import 'dart:convert';

UserModel userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.image,
    required this.id,
    required this.name,
    required this.email
  });

  String? image;
  String name;
  String id;
  String email;

factory UserModel.fromJson(Map<String, dynamic>? json) => UserModel(
  id: json?["id"] ?? "",
  name: json?["name"] ?? "",
  image: json?["image"],
  email: json?["email"] ?? "",
);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name":name,
        "image": image,
        "email":email  
  };


      UserModel copyWith({
      String? image, name,
    })=>UserModel(
      id: id,
      name: name??this.name, 
      email: email,
      image: image??this.image,
    );



}