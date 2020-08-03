import 'dart:convert';
import 'package:gociapp/Data/Model/Panier.dart';

class OrderContent {

   int total = 0;
  List<Panier> paniers = new List();

  OrderContent({this.total, this.paniers});

  factory OrderContent.fromJson(Map<String, dynamic> json) {
    return OrderContent(
      paniers :  (jsonDecode(json['paniers']) as List).map((e) => Panier.fromJson(e)).toList(),
      total: json["total"] as int,
    );
  }
  Map toJson(){
    return {
      "paniers" :  this.paniers != null ? jsonEncode(this.paniers): null,
      'total': total
    };
  }
}