import 'dart:convert';
import 'dart:developer';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/Data/Model/OrderContent.dart';
import 'package:gociapp/Data/Model/Panier.dart';
import 'package:gociapp/Data/Model/Produit.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';


Future<List<Produit>>  getProduitsByCategorieName(String categorieName) async {

  final response = await http.get(baseUrl + "produits/" + categorieName);
  if (response.statusCode == 200) {
    var  listeProduitApi  = json.decode(response.body) as List;
    List<Produit> listeProduit  = listeProduitApi.map<Produit>((m) => new Produit.fromJson(m)).toList();
    return listeProduit;
  }else {
    return null;
  }
}

Future<List<Produit>>  recommander() async {
  final response = await http.get(baseUrl + "recommanded");
  if (response.statusCode == 200) {
    var  listeProduitApi  = json.decode(response.body) as List;
    List<Produit> listeProduit  = listeProduitApi.map<Produit>((m) => new Produit.fromJson(m)).toList();
    return listeProduit;
  }else {
    return null;
  }
}

Future<int> addPanier(Panier panier) async {
  LocalStorage storage = new LocalStorage('panier');
  var panierCommandeStorage = storage.getItem("panier");
  OrderContent orderContent = panierCommandeStorage != null ? OrderContent.fromJson(jsonDecode(panierCommandeStorage)) : new OrderContent();
  int price = (int.parse(panier.produit.prix) * panier.quantite);
  storage.deleteItem("panier");
  if(panierCommandeStorage != null){
    bool existe = false;
    orderContent.paniers.forEach((element) {
      if(element.produit.id == panier.produit.id){
        orderContent.total += price;
        existe = true;
        element.quantite += panier.quantite;
      }
    });
    if(!existe){
      orderContent.total += price;
      orderContent.paniers.add(panier);
    }
  }else {
    List<Panier> paniers = new List();
    paniers.add(panier);
    orderContent.paniers = paniers;
    int total = price;
    orderContent.total = total ;
  }
  storage.setItem("panier", jsonEncode(orderContent.toJson()));
  return orderContent.total;
}



Future<OrderContent> removePanier(Panier panier) async {
  LocalStorage storage = new LocalStorage('panier');
  var panierCommandeStorage = storage.getItem("panier");
  OrderContent orderContent = OrderContent.fromJson(jsonDecode(panierCommandeStorage));
  for(var i = 0 ; i < orderContent.paniers.length ; i++){
      if(orderContent.paniers[i].produit.id == panier.produit.id){
        orderContent.paniers.removeAt(i);
        orderContent.total -= 1;
      }
  }
  storage.setItem("panier", jsonEncode(orderContent.toJson()));
  return orderContent;
}


Future<String> disecreaseProductCart(Panier panier) async{
  LocalStorage storage = new LocalStorage('panier');
  var panierStorage = storage.getItem("panier");
  if(panierStorage != null){
    OrderContent orderContent = OrderContent.fromJson(json.decode(panierStorage));
    List<Panier> paniers = List.of(orderContent.paniers);
    int total = orderContent.total;
    orderContent.paniers.clear();
    orderContent.total = 0;
    storage.deleteItem("panier");
    paniers.forEach((element) {
      if(element.produit.id == panier.produit.id){
        element.quantite -= panier.quantite;
        total -= int.parse(panier.produit.prix);
      }
    });
    if(paniers.length != 0){
      orderContent.paniers = List.of(paniers);
      orderContent.total = total;
      storage.setItem("panier", jsonEncode(orderContent.toJson()));
    }
  }
  return "Produit supprimé avec success";
}

Future<int> cartSize() async {
  LocalStorage storage = new LocalStorage('panier');
  var panierStorage = storage.getItem("panier");
  int size = 0;
  if(panierStorage != null){
    OrderContent orderContent = OrderContent.fromJson(jsonDecode(panierStorage));
    size = orderContent.paniers.length;
  }
  return size;
}

Future<OrderContent> getAlllProductCart() async {
  LocalStorage storage = new LocalStorage('panier');
  var panierStorage = storage.getItem("panier");
  return panierStorage != null ? OrderContent.fromJson(jsonDecode(panierStorage)) : new OrderContent();
}

