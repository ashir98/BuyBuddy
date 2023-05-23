// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    String id;
    String name;
    String image;
    String price;
    String description;
    String status;
    bool isFav;

    ProductModel({
        required this.id,
        required this.name,
        required this.image,
        required this.price,
        required this.description,
        required this.status,
        required this.isFav
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"].toString(),
        description: json["description"],
        status: json["status"],
        isFav: false
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "description": description,
        "status": status,
        "isFav": isFav
    };
}


List<ProductModel> topProducts = [
  ProductModel(
    id: "1", 
    name: "Laptop", 
    image: "assets/images/products/laptop.png", 
    price: "500", 
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing", 
    status: "normal", 
    isFav: false
  ),
  ProductModel(
    id: "1", 
    name: "Laptop", 
    image: "assets/images/products/laptop.png", 
    price: "500", 
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing", 
    status: "normal", 
    isFav: false
  ),
  ProductModel(
    id: "1", 
    name: "Laptop", 
    image: "assets/images/products/laptop.png", 
    price: "500", 
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing", 
    status: "normal", 
    isFav: false
  ),

  ProductModel(
    id: "1", 
    name: "Laptop", 
    image: "assets/images/products/laptop.png", 
    price: "500", 
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing", 
    status: "normal", 
    isFav: false
  ),  
  ProductModel(
    id: "1", 
    name: "Laptop", 
    image: "assets/images/products/laptop.png", 
    price: "500", 
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing", 
    status: "normal", 
    isFav: false
  ),  


  ProductModel(
    id: "1", 
    name: "Laptop", 
    image: "assets/images/products/laptop.png", 
    price: "500", 
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing", 
    status: "normal", 
    isFav: false
  ),  

  ProductModel(
    id: "1", 
    name: "Laptop", 
    image: "assets/images/products/laptop.png", 
    price: "500", 
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing", 
    status: "normal", 
    isFav: false
  ),            

  
];
