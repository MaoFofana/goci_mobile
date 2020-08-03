import 'package:flutter_html/flutter_html.dart';
import 'package:gociapp/Data/Api/Produits.dart';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/Data/Model/Panier.dart';
import 'package:gociapp/Data/Model/Produit.dart';
import 'package:gociapp/Library/carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:gociapp/UI/CartUIComponent/CartLayout.dart';
import 'package:localstorage/localstorage.dart';

class detailProduk extends StatefulWidget {
  Produit produit;
  String vandorName;

  detailProduk(this.produit, {this.vandorName});

  @override
  _detailProdukState createState() => _detailProdukState(this.produit);
}

/// Detail Product for Recomended Grid in home screen
class _detailProdukState extends State<detailProduk> {

  int quantity = 1;
  LocalStorage dataStorage  = new LocalStorage("data");

  /// Declaration List item HomeGridItemRe....dart Class
  final Produit produit;
  _detailProdukState(this.produit);

  int valueItemChart = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _panierSizeTraitement();
  }

  _panierSizeTraitement()  async {
    int size = await cartSize();
    setState(() {
      valueItemChart = size;
    });
  }


  /// Custom Text black
  static var _customTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Gotik",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  /// Custom Text for Header title
  static var _subHeaderCustomStyle = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w700,
      fontFamily: "Gotik",
      fontSize: 16.0);

  Widget build(BuildContext context) {
    _panierSizeTraitement();
    return Scaffold(
      key: _key,

      appBar: AppBar(
        iconTheme: IconThemeData(
          color: colorGoci, //change your color here
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  PageRouteBuilder(pageBuilder: (_, __, ___) => new cart()));
            },
            child: Stack(
              alignment: AlignmentDirectional(-1.0, -0.8),
              children: <Widget>[
                IconButton(
                  onPressed: null,
                    icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black26,
                )),
                CircleAvatar(
                  radius: 10.0,
                  backgroundColor:colorGoci,
                  child: Text(
                    valueItemChart.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Details du produit",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black54,
            fontSize: 17.0,
            fontFamily: "Gotik",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// Header image slider
                  Container(
                    height: 300.0,
                    child: Hero(
                      tag: "hero-grid-${produit.id}",
                      child: Material(
                        child: new Carousel(
                          dotColor: Colors.black26,
                          dotIncreaseSize: 1.7,
                          dotBgColor: Colors.transparent,
                          autoplay: false,
                          boxFit: BoxFit.cover,
                          images: [                         
                            NetworkImage(produit.image)
                          ],
                        ),
                      ),
                    ),
                  ),
                  /// Background white title,price and ratting
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Color(0xFF656565).withOpacity(0.15),
                        blurRadius: 1.0,
                        spreadRadius: 0.2,
                      )
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 5.0)),
                          Center(
                            child: Text(
                              widget.vandorName != null ? widget.vandorName: "",
                              textAlign: TextAlign.center,
                              style:_customTextStyle,

                            ) ,
                          )
                         ,
                          Text(
                            produit.nom,
                            style:  TextStyle(
                                color: Colors.black,
                                fontFamily: "Gotik",
                                fontSize: 17.0,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5.0)),
                          Text(
                           produit.prix,
                            style:  TextStyle(
                                color: Colors.black,
                                fontFamily: "Gotik",
                                fontSize: 17.0,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5.0)),
                          Text(
                            produit.regular_price + " FCFA",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Gotik",
                                fontSize: 17.0,
                                decoration: TextDecoration.lineThrough
                            ),

                          ),

                          Padding(padding: EdgeInsets.only(top: 10.0)),
                         Divider(
                            color: Colors.black12,
                            height: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  /// Background white for description
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height:MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "",
                                style: _subHeaderCustomStyle,
                              ),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {},
                                child: Html(data: produit.description),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          /// If user click icon chart SnackBar show
          /// this code to show a SnackBar
          /// and Increase a valueItemChart + 1
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 0.0, bottom: 20.0),
                      child: Container(
                        width: 112.0,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            border: Border.all(
                                color: Colors.black12.withOpacity(0.1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceAround,
                          children: <Widget>[

                            /// Decrease of value item
                            InkWell(
                              onTap: () {
                                setState(() {
                                  quantity = quantity != 1? quantity - 1 : quantity - 0;
                                });
                              },
                              child: Container(
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            color: Colors.black12
                                                .withOpacity(0.1)))),
                                child: Center(child: Text("-")),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 13.0),
                              child: Text(quantity.toString()),
                            ),

                            /// Increasing value of item
                            InkWell(
                              onTap: () {
                                setState(() {
                                  quantity = quantity + 1;
                                });
                              },
                              child: Container(
                                height: 30.0,
                                width: 28.0,
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: Colors.black12
                                                .withOpacity(0.1)))),
                                child: Center(child: Text("+")),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /// Button Pay
                    InkWell(
                      onTap: () async {
                        Panier paniera = new Panier(produit: produit, quantite: quantity);
                          var resultat = "Produit ajouté avec succes ";
                          int total = await addPanier(paniera);
                          int size = await cartSize();
                          setState(() {
                            valueItemChart = size;
                          });
                        var snackbar = SnackBar(
                          content: Text(resultat.toString()),
                        );


                        _key.currentState.showSnackBar(snackbar);
                      },
                      child: Container(
                        height: 45.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: colorGoci,
                        ),
                        child: Center(
                          child: Text(
                            "Ajouter au panier",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}