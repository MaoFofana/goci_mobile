import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:http/http.dart' as http;
import 'package:gociapp/Data/Model/Commande.dart';
import 'package:localstorage/localstorage.dart';
class order extends StatefulWidget {
  @override
  _orderState createState() => _orderState();
}

class _orderState extends State<order> {

  List<Commande> listeCommande = new List();

  @override
  void initState(){
    _getAllCommande();
  }

  Future<Null> _getAllCommande() async{
    LocalStorage storage = new LocalStorage("data");

    String id = storage.getItem('id').toString();

    final responde = await http.get(baseUrl + "commandes/" + id);

    if(responde.statusCode == 200){
      var data = jsonDecode(responde.body) as List;
      log(data.toString());
      setState(() {
        listeCommande = data.map((m) => new Commande.fromJson(m)).toList();
      });

    }else {
      log("dd");
    }
  }

  static var _txtCustom = TextStyle(
    color: Colors.black54,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Gotik",
  );
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Liste de vos commandes",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFFCD0007)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 23),),
              Center(child: Text("Voir la liste de vos commandes"),),
              listeCommande.length != 0 ?
             GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 2,
              crossAxisCount: 1,
              primary: false,
              children:List.generate(
            /// Get data in flashSaleItem.dart (ListItem folder)
            listeCommande.length,
                (index) => itemGrid(listeCommande[index]),
          ),
            ) :Padding(padding: EdgeInsets.only(top: 150),child: Center(child: Text('Aucune commande nest diponible', textAlign: TextAlign.center,style: TextStyle(fontSize: 12.0),),) ,)

            ],
          ),
        ),
      )
    );
  }
}


class itemGrid extends StatelessWidget {
  final Commande commande ;
  itemGrid(this.commande);
  static var _txtCustom = TextStyle(
    color: Colors.black54,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Gotik",
  );

  String staut(String staut){
    String returnValue = "";
    switch(staut){
      case "on-hold" : return "En attente d'approbation";
      case "processing" : return "Près pour la livraison";
      case "completed" : return "Livré";
      case "cancelled" : return "Annulée";
      case "driver-assigned" : return "Livreur attribué";
      case "out-for-delivery" : return "En Cours de Livraison";
      default : return  "En Attente";
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(
          top: 8.0, bottom: 10.0, left: 10.0, right: 10.0),
      child: Container(
        height:100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 4.5,
                spreadRadius: 1.0,
              )
            ]),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset("assets/img/bag.png"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  staut(commande.status),
                  textAlign: TextAlign.center,
                  style: _txtCustom.copyWith(
                      fontWeight: FontWeight.w700),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Text(
                  "Date : "+commande.date,
                  style: _txtCustom.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                      color: Colors.black38),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                Text(
                  "Produits : "+commande.nombre.toString(),
                  style: _txtCustom.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                      color: Colors.black38),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                Text(
                  " Total: " + commande.prix.toString() + " FCFA",
                  style: _txtCustom.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                      color: Colors.black38),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}



/// Constructor Data Orders
class qeueuItem extends StatelessWidget {
  @override
  static var _txtCustomOrder = TextStyle(
    color: Colors.black45,
    fontSize: 13.5,
    fontWeight: FontWeight.w600,
    fontFamily: "Gotik",
  );

  String icon, txtHeader, txtInfo, time;
  double paddingValue;

  qeueuItem(
      {this.icon, this.txtHeader, this.txtInfo, this.time, this.paddingValue});

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 13.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(icon),
              Padding(
                padding: EdgeInsets.only(
                    left: 8.0,
                    right: mediaQueryData.padding.right + paddingValue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(txtHeader, style: _txtCustomOrder),
                    Text(
                      txtInfo,
                      style: _txtCustomOrder.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          color: Colors.black38),
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: _txtCustomOrder..copyWith(fontWeight: FontWeight.w400),
              )
            ],
          ),
        ],
      ),
    );
  }
}
