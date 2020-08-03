import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/Data/Model/Produit.dart';
import 'package:gociapp/UI/Component/ProductGrid.dart';
import 'package:http/http.dart' as http;

class searchAppbar extends StatefulWidget {
  @override
  _searchAppbarState createState() => _searchAppbarState();
}
class _searchAppbarState extends State<searchAppbar> {
  static TextEditingController searchController = new TextEditingController();
  List<Produit> listeProduit = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Null>  search(String searchWord) async {
    final response = await http.get(baseUrl + "search/"+searchWord );
    if (response.statusCode == 200) {
      var  listeProduitApi  = json.decode(response.body) as List;
      setState(() {
        listeProduit  = listeProduitApi.map<Produit>((m) => new Produit.fromJson(m)).toList();
      });
     log(listeProduit.length.toString());
    }else {
      throw Exception('Erreur de chargement');
    }

  }


  @override
  /// Sentence Text header "Hello i am Treva.........."
  var _textHello = Padding(
    padding: const EdgeInsets.only(right: 10.0, left: 10.0),
    child: Text(
      "Bienvenu sur la zone de recherche de GOCI. \n Qu'elle produit cherchez vous?",
      style: TextStyle(
          letterSpacing: 0.1,
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
          color: Colors.black54,
          fontFamily: "Gotik"),
    ),
  );

  /// Item TextFromField Search


  /// Popular Keyword Item
  var _sugestedText = Container(
    height: 145.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 20.0),
          child: Text(
            "Recherche populaire",
            style: TextStyle(fontFamily: "Gotik", color: Colors.black26),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 20.0)),
        Expanded(
            child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 20.0)),
            KeywordItem(
              title: "Iphone X",
              title2: "Mackbook",
            ),
            KeywordItem(
              title: "Samsung",
              title2: "Apple",
            ),
            KeywordItem(
              title: "Note 9",
              title2: "Nevada",
            ),
            KeywordItem(
              title: "Watch",
              title2: "PC",
            ),
          ],
        ))
      ],
    ),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: colorGoci,
        ),
        title: Text(
          "Recherche",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// Caliing a variable
                _textHello,
                Padding(
                  padding: const EdgeInsets.only(top: 35.0, right: 20.0, left: 20.0),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15.0,
                              spreadRadius: 0.0)
                        ]),
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Theme(
                            data: ThemeData(hintColor: Colors.transparent),
                            child:
                            TextFormField(
                              controller:  searchController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabled: false,
                                  suffixIcon: IconButton(icon: Icon(
                                    Icons.search,
                                    color: colorGoci,
                                    size: 28.0,
                                  ),
                                    onPressed: () async {
                                        await search(searchController.text);
                                    },),
                                  hintText: "Trouver ce que vous voulez",
                                  hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: "Gotik",
                                      fontWeight: FontWeight.w400)),
                            ),
                          )
                      ),
                    ),
                  ),
                ),
                _sugestedText,
                GridView.count(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 0.545,
                  crossAxisCount: 2,
                  primary: false,
                  children:List.generate(
                    /// Get data in flashSaleItem.dart (ListItem folder)
                    listeProduit.length,
                        (index) => ProductGrid(listeProduit[index]),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 30.0, top: 2.0))
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/// Popular Keyword Item class
class KeywordItem extends StatelessWidget {
  @override
  String title, title2;

  KeywordItem({this.title, this.title2});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:4.0,left: 3.0),
          child: Container(
            height: 29.5,
            width: 90.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.5,
                  spreadRadius: 1.0,
                )
              ],
            ),
            child: Center(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, fontFamily: "Sans"),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 15.0)),
        Container(
          height: 29.5,
          width: 90.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.5,
                spreadRadius: 1.0,
              )
            ],
          ),
          child: Center(
            child: Text(
              title2,
              style: TextStyle(
                color: Colors.black54,
                fontFamily: "Sans",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

