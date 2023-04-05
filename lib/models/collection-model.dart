import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<BooksModel> booksModelFromJson(String str) => List<BooksModel>.from(json.decode(str).map((x) => BooksModel.fromJson(x)));

String booksModelToJson(List<BooksModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BooksModel {
  BooksModel({
    this.name,
    this.link,
    this.createTime,
    this.collectionId,
  });

  String? name;
  String? link;
  Timestamp? createTime;
  String? collectionId;

  factory BooksModel.fromJson(Map<String, dynamic> json) => BooksModel(
    name: json["name"],
    link: json["link"],
    createTime: json["createTime"],
    collectionId: json["collectionId"],
  );

  Map<String, dynamic> toJson() => {
    "full_name": name,
    "link": link,
    "createTime": createTime,
    "collectionId": collectionId,
  };
}