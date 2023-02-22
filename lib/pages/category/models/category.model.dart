// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);
import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
    Category({
        required this.id,
        required this.name,
        required this.description,
        required this.image,
        required this.isActive,
    });

    String id;
    String name;
    String description;
    String image;
    bool isActive;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "is_active": isActive,
    };
}
