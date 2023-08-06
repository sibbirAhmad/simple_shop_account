import 'package:flutter/foundation.dart';
import 'dart:convert';

class UserDataModel{

  UserDataModel({
    this.id,
    required this.userName,
    required this.password
});
  int? id;
  String userName;
  String password;

  //Todo : Convert to json

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    id: json["id"],
    userName: json["username"],
    password: json["password"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "username": userName,
    "email": password,
  };

}

class TestModel{
  int id;
  int userId;
  String tittle;

  TestModel({
    required this.id, required this.userId, required this.tittle
});

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
    id: json["id"],
    userId: json["userId"],
    tittle: json["tittle"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "tittle": tittle,
  };

  List<TestModel> toUserModel(String str) =>
      List<TestModel>.from(json.decode(str).map((x) => TestModel.fromJson(x)));

}

class ProductDataModel{
  String productName;
  String sellTime;
  double buyPrice;
  double sellPrice;
  int? sellerId;
  int? id;

  ProductDataModel({
    required this.productName,
    required this.sellTime,
    required this.buyPrice,
    required this.sellPrice,
    this.sellerId,
    this.id
});

  factory ProductDataModel.fromJson(Map<String, dynamic> json) => ProductDataModel(
    id: json["id"],
    productName: json["productName"],
    sellTime: json["sellTime"],
    buyPrice: json["buyPrice"],
    sellPrice: json["sellPrice"],
  );

}
List<ProductDataModel> toSellModel(String str) =>
    List<ProductDataModel>.from(json.decode(str).map((x) => ProductDataModel.fromJson(x)));