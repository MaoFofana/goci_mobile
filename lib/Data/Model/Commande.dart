
import 'dart:convert';
import 'dart:developer';

import 'package:gociapp/Data/Model/Produit.dart';

class Commande {
  final String date;
  final int nombre ;
  final String status;
  final List<Produit> produits;
  final int prix;
  Commande({this.date, this.nombre, this.produits, this.status, this.prix});
  factory Commande.fromJson(Map<String , dynamic> json) {
    var  produitApi = json['items'] as List;
    return Commande(
      date: json['date'] as String,
      nombre: json['nombre'] as int,
      status: json['status'] as String,
      produits: produitApi.map((m) => new Produit.fromJson(m)).toList(),
      prix: json['prix']
    );
  }
}