import 'dart:convert';

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) =>
    json.encode(data.toJson());

class ProductResponse {
  bool? success;
  List<Product>? data;

  ProductResponse({
    this.success,
    this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Product {
  int? id;
  String? name;
  String? category;
  String? price;
  String? image;
  String? link;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    this.name,
    this.category,
    this.price,
    this.image,
    this.link,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        price: json["price"],
        image: json["image"],
        link: json["link"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "price": price,
        "image": image,
        "link": link,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
