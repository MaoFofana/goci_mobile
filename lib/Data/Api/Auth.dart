import 'dart:convert';
import 'dart:developer';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/Data/Model/User.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';


Future<String>  inscriptionOrUpdate(User user) async {
  final LocalStorage storage = new LocalStorage('data');
    final response = await http.post(baseUrl + "inscription_update",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "name": user.nom,
          "password": user.password,
          "email": user.email,
          "address" : user.address,
          "city": user.city,
          "id" : user.id,
          "phone" : user.phone
        })
    );
    log(response.body);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
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
    return data['message'];
  } else {
    return null;
  }
}


Future<String>  connection(User user) async {
  final LocalStorage storage = new LocalStorage('data');
  final response = await http.post(baseUrl + "connexion",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "password" : user.password,
        "email" : user.email
      })
  );
  log(response.body);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
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
    return data["message"];
  }else {
    return "Veuillez vous assurer que votre email a été enregistrer";
  }
}

Future<String>  updateAccount(String nom ,String numero , String address1, String city , String email, int id) async {
  final LocalStorage storage = new LocalStorage('data');
  final response = await http.post(baseUrl + "users/update",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "name": nom,
        "email": email,
        "id": id,
        "address": address1,
        "city": city,
        "numero": numero
      })
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
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
    return data["message"];
  }else {
    print('nullll');
    return null;
  }
}

Future<User>  getUser(String id) async {
  final response = await http.get(baseUrl + "users/$id",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    print(data);
    if(data['message'] == "valider"){
      return User.fromJson(data);
    }else  {
      return data["message"];
    }
  }else {
    print('nullll');
    return null;
  }
}


Future<String>  updatePassword(String id , String oldPassword, String newPassword) async {
  print("il est rentreee hinn ");
  final response = await http.post(baseUrl + "password/update",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "id" :id,
        "old_password": oldPassword,
        "new_password": newPassword,
      })
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    return data["message"];
  }else {
    return null;
  }
}








