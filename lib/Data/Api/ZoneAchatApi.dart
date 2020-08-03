import 'dart:convert';
import 'package:gociapp/Data/Model/BoutiqueProduits.dart';
import 'package:http/http.dart' as http;


Future<List<BoutiqueProduits>>  getProduitsByStoreId(String id) async {
  final response = await http.get("https://www.goci.ci/wp-json/dokan/v1/stores/" + id +"/products?per_page=100");
  if (response.statusCode == 200) {
    var  listeProduitApi  = json.decode(response.body) as List;
    List<BoutiqueProduits> listeProduit  = listeProduitApi.map<BoutiqueProduits>((m) => new BoutiqueProduits.fromJson(m)).toList();
    return listeProduit;
  }else {
    return null;
  }
}
