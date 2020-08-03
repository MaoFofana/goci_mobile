import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:gociapp/Data/Model/Commande.dart';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/Data/Model/SendCommand.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';





Future<String> sendOrder(SendCommand command) async{
  LocalStorage storage = new LocalStorage("data");
  final response = await http.post(baseUrl + "commande",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
          body: jsonEncode({
            'id': command.id,
            "shipping": command.shipping,
            "sub_total": command.orderContent.total,
            "name": command.name,
            "email": command.email,
            "phone": command.phone,
            "address": command.address,
            "city": command.city,
            "password": command.password,
            "paniers" : jsonEncode(command.orderContent.paniers),
            "total" : command.total
          })
  );
  log(response.body);
  if(response.statusCode == 200){
    Map<String, dynamic> data  = json.decode(response.body);
    String returnValue =  data["message"].toString();
    if(data['message'] == "valider"){
      storage.deleteItem("name");
      storage.deleteItem("id");
      storage.deleteItem("email");
      storage.deleteItem("address");
      storage.deleteItem("city");
      storage.deleteItem("phone");


      storage.setItem("name", data['name']);
      storage.setItem('id', data['id']);
      storage.setItem("email", data['email']);
      storage.setItem("address", data['address']);
      storage.setItem("city", data['city']);
      storage.setItem("phone", data['phone']);
    }
    LocalStorage storagePanier = new LocalStorage('panier');
    storagePanier.deleteItem("panier");
    return returnValue;
  }else {return null;}
}



