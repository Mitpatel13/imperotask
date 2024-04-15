// To parse this JSON data, do
//
//     final ceramicModel = ceramicModelFromJson(jsonString);

import 'dart:convert';

CeramicModel ceramicModelFromJson(String str) => CeramicModel.fromJson(json.decode(str));

String ceramicModelToJson(CeramicModel data) => json.encode(data.toJson());

class CeramicModel {
  final int? status;
  final String? message;
  final Result? result;

  CeramicModel({
    this.status,
    this.message,
    this.result,
  });

  factory CeramicModel.fromJson(Map<String, dynamic> json) => CeramicModel(
    status: json["Status"],
    message: json["Message"],
    result: json["Result"] == null ? null : Result.fromJson(json["Result"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Result": result?.toJson(),
  };
}

class Result {
  final List<Category>? category;

  Result({
    this.category,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    category: json["Category"] == null ? [] : List<Category>.from(json["Category"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
  };
}

class Category {
  final int? id;
  final String? name;
  final int? isAuthorize;
  final int? update080819;
  final int? update130919;
  final List<SubCategory>? subCategories;

  Category({
    this.id,
    this.name,
    this.isAuthorize,
    this.update080819,
    this.update130919,
    this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["Id"],
    name: json["Name"],
    isAuthorize: json["IsAuthorize"],
    update080819: json["Update080819"],
    update130919: json["Update130919"],
    subCategories: json["SubCategories"] == null ? [] : List<SubCategory>.from(json["SubCategories"]!.map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "IsAuthorize": isAuthorize,
    "Update080819": update080819,
    "Update130919": update130919,
    "SubCategories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
  };
}

class SubCategory {
  final int? id;
  final String? name;
  final List<Product>? product;

  SubCategory({
    this.id,
    this.name,
    this.product,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["Id"],
    name: json["Name"],
    product: json["Product"] == null ? [] : List<Product>.from(json["Product"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Product": product == null ? [] : List<dynamic>.from(product!.map((x) => x.toJson())),
  };
}

class   Product {
  final String? name;
  final String? priceCode;
  final String? imageName;
  final int? id;

  Product({
    this.name,
    this.priceCode,
    this.imageName,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["Name"],
    priceCode: json["PriceCode"],
    imageName: json["ImageName"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "PriceCode": priceCode,
    "ImageName": imageName,
    "Id": id,
  };
}
