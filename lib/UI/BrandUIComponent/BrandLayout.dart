import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/Data/Model/Boutique.dart';
import 'package:gociapp/UI/BrandUIComponent/BrandDetail.dart';
import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:http/http.dart' as http;
import 'package:find_dropdown/find_dropdown.dart';



class brand extends StatefulWidget {
  String name;
  brand({this.name});
  @override
  _brandState createState() => _brandState();
}

class _brandState extends State<brand> {

  List<Boutique> listeBoutique = new List();
  List<Boutique> globalListBoutique = new List();
  String city;
  bool searchActive = false;
  TextEditingController _nom = new TextEditingController();
  List<String> cities = [
    "Cocody","Plateau","Attecoubé","Adjamé","Abobo","Yopougon","Songon","Bingerville","Anyama","Yopougon","Koumassi","Marcory","Treichville","Port-bouet","Zone 4","Zone 3","Treichville","Grand-bassam"
  ];
  @override
  void initState() {
    // TODO: implement initState
    obtenirBoutique();
    super.initState();
  }

  Future<Null> obtenirBoutique() async {
    final response = await http.get(
        "https://www.goci.ci/wp-json/dokan/v1/stores?per_page=100");
    if (response.statusCode == 200) {
      log(response.statusCode.toString());
      var listApi  = json.decode(response.body) as List;
      for(int i = 0 ; i< listApi.length ; i++){
        Boutique boutique = Boutique.fromJson(listApi[i]);
        setState(() {
          if(widget.name != null){
            if(boutique.address.city == widget.name){
              listeBoutique.add(boutique);
            }
          }else {
            listeBoutique.add(boutique);
          }
          globalListBoutique.add(boutique);

        }
        );
      }

    } else {
      throw "Probleme";
    }
  }

  void search(){

    List<Boutique> listSearchBoutique = [];

    if(this.city.isNotEmpty){
      globalListBoutique.forEach((element) {
        if(element.address.city == this.city){
          log(element.address.city);
          listSearchBoutique.add(element);
        }
      });
    }else {
      listSearchBoutique.addAll(globalListBoutique);
    }

   if(_nom.text.isNotEmpty){
     List<Boutique>  nomBoutiques = new List();

     if(listSearchBoutique.length != 0){
       listSearchBoutique.forEach((element) {
         if(element.storeName.toLowerCase().contains(_nom.text.toLowerCase())){
           nomBoutiques.add(element);
         }
       });
     }
     listSearchBoutique.clear();
     nomBoutiques.forEach((element) {
       listSearchBoutique.add(element);
     });
   }

   setState(() {
      listeBoutique.clear();
      listSearchBoutique.forEach((element) {listeBoutique.add(element);});
      listSearchBoutique.clear();
      searchActive = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    /// Component appbar
    var _appbar = AppBar(
      backgroundColor: Color(0xFFFFFFFF),
      elevation: 0.0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          "Zone d'achat",
          style: TextStyle(
              fontFamily: "Gotik",
              fontSize: 20.0,
              color: Colors.black54,
              fontWeight: FontWeight.w700),
        ),
      ),
      actions: <Widget>[
        InkWell(
          onTap: () async {
            await animated_dialog_box.showRotatedAlert(
                title: Center(
                    child:
                    Text("Recherche")
                ), // IF YOU WANT TO ADD
                context: context,
                 secondButton: MaterialButton(
                  // FIRST BUTTON IS REQUIRED
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  color: colorGoci,
                  child: Text('Chercher'),
                  onPressed: () {
                    search();
                    setState(() {
                      city = "";
                      _nom.clear();
                    });
                    Navigator.of(context).pop();
                  },
                ),
                firstButton : MaterialButton(
                  // OPTIONAL BUTTON
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  color: colorGoci,
                  child: Text('Annuler'),
                  onPressed: () {
                    setState(() {
                      searchActive = false;
                    });

                    Navigator.of(context).pop();
                  },
                ),
                icon: Icon(Icons.search , size: 20,),
                yourWidget:
                Container(
                    child: SingleChildScrollView(
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextField(
                            controller: _nom,
                            decoration: InputDecoration.collapsed(
                                hintText: '   Nom',border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                            ), hintStyle: TextStyle(color: Colors.black,)),
                          ),  SizedBox(height: 10.0),
                          FindDropdown(
                            items: cities,
                            label: "Localité",
                            selectedItem: "Aucun",
                            searchBoxDecoration: InputDecoration(hintText: "Chercher"),
                            onChanged: (String item){
                              setState(() {
                                searchActive = true;
                               city = item;
                              });
                            },
                          ),
                        ],
                      ),)
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.search,
              size: 27.0,
              color: colorGoci,
            ),
          ),
        )
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Scaffold(
        /// Calling variable appbar
          appBar: _appbar,
          body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  listeBoutique.length != 0 ?
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
                      listeBoutique.length,
                          (index) => itemCard(listeBoutique[index]),
                    ),
                  ) :Container(child: Center(child:
                  CircularProgressIndicator(),),height:MediaQuery.of(context).size.height -140,)
                ],
              ),
            )
          )),
    );
  }
}

/// Constructor for itemCard for List Menu
class itemCard extends StatelessWidget {
  final Boutique brand ;
  itemCard(this.brand);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => new brandDetail(brand),
                transitionDuration: Duration(milliseconds: 600),
                transitionsBuilder:
                    (_, Animation<double> animation, __, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: child,
                  );
                }),
          );
        },
        child: Container(
          width: 400.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child:  Hero(
            tag: 'hero-tag-${brand.id}',
            child: Material(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                      image: AssetImage("assets/avatars/espace-a-louer.jpg"), fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFABABAB).withOpacity(0.3),
                      blurRadius: 1.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.black12.withOpacity(0.1),
                    ),
                    child:Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 17.0)),
                        Center(
                          child: Text(
                            brand.storeName,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Berlin",
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            brand.firstName != null && brand.lastName != null? brand.firstName + " " + brand.lastName : "",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Berlin",
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            brand.address.city != null? brand.address.city : "",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Berlin",
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            brand.address.state != null? brand.address.state : "",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Berlin",
                              fontSize: 15.0,
                            ),
                          ),
                        ),

                      ],
                    )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
