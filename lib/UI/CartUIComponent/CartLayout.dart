import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gociapp/Data/Api/Produits.dart';
import 'package:gociapp/Data/Model/OrderContent.dart';
import 'package:gociapp/Data/Model/Panier.dart';
import 'package:gociapp/Data/Model/SendCommand.dart';
import 'package:gociapp/UI/CartUIComponent/Delivery.dart';
import 'package:localstorage/localstorage.dart';


class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  final LocalStorage dataStorage = new LocalStorage('data');
  List<Panier> listPanier = new List();
  int pay = 0;
  @override
  void initState() {
    super.initState();
    _getProduitCart();
  }
  _getProduitCart() async{
    OrderContent orderContent =  await getAlllProductCart();
    List<Panier> listPaniers = orderContent.paniers;
    setState(() {
      listPanier = listPaniers.map((e) => Panier(quantite: e.quantite , produit: e.produit)).toList();
     pay = orderContent.total;
    });

  }
  /// Declare price and value for chart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Color(0xFFCD0007)),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "Panier",
              style: TextStyle(
                  fontFamily: "Gotik",
                  fontSize: 18.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700),
            ),
            elevation: 0.0,
          ),

          /// Checking item value of cart
          body: listPanier.length>0 ?
          ListView.builder(
            itemCount: listPanier.length,
            itemBuilder: (context,position){
              ///
              /// Widget for list view slide delete
              ///
              return Slidable(
                actionExtentRatio: 0.25,
                actions: <Widget>[
                ],
                secondaryActions: <Widget>[
                  new IconSlideAction(
                    key: Key(listPanier[position].produit.id.toString()),
                    caption: 'Supprimer',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () async {
                     OrderContent orderContent =  await removePanier(listPanier[position]);
                     List<Panier> listPaniers = orderContent.paniers;
                     setState(() {
                       listPanier = listPaniers.map((e) => Panier(quantite: e.quantite , produit: e.produit)).toList();
                       pay = orderContent.total;
                     });
                      /// SnackBar show if cart delet
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text("Prouit supprimer"),duration: Duration(seconds: 2),backgroundColor: Colors.red,));
                    },
                  ),
                ],
                delegate: new SlidableDrawerDelegate(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 1.0, left: 13.0, right: 13.0),
                  /// Background Constructor for card
                  child: Container(
                    height: ((position + 1) != listPanier.length? 168.0 : 220.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 3.5,
                          spreadRadius: 0.4,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(10.0),

                                /// Image item
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12.withOpacity(0.1),
                                              blurRadius: 0.5,
                                              spreadRadius: 0.1)
                                        ]),
                                    child: Image.network('${listPanier[position].produit.image}',
                                      height: 130.0,
                                      width: 120.0,
                                      fit: BoxFit.cover,
                                    ))),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 10.0, right: 5.0),
                                child: Column(

                                  /// Text Information Item
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${listPanier[position].produit.nom}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Sans",
                                        color: Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    Padding(padding: EdgeInsets.only(top: 10.0)),
                                    Text('${listPanier[position].produit.prix} FCFA'),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18.0, left: 0.0),
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
                                              onTap: () async {
                                                if(listPanier[position].quantite > 1){
                                                  Panier panier = new Panier(produit: listPanier[position].produit, quantite: 1);
                                                  await disecreaseProductCart(panier);
                                                  _getProduitCart();
                                                }

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
                                                  horizontal: 18.0),
                                              child: Text(listPanier[position].quantite.toString()),
                                            ),

                                            /// Increasing value of item
                                            InkWell(
                                              onTap: () async {
                                                Panier panier = new Panier(produit: listPanier[position].produit, quantite: 1);
                                                await addPanier(panier);
                                                _getProduitCart();
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 8.0)),
                        Divider(
                          height: 2.0,
                          color: Colors.black12,
                        ),
                        ((position + 1) != listPanier.length)?
                        Padding(padding: EdgeInsets.only(bottom: 8.0)):
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 9.0, left: 10.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                /// Total price of item buy
                                child: Text(
                                  "Total : $pay FCFA" ,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.5,
                                      fontFamily: "Sans"),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                var  id = dataStorage.getItem('id');// != null? dataStorage.getItem("id") : 0;
                                 double fraisLivraison = 0;
                                double poids = 0.0;
                                 listPanier.forEach((element) {
                                   double poidsElement = (double.parse(element.produit.poids));
                                   if(poids < poidsElement ){
                                     poids = poidsElement;
                                   }
                                 });
                                 LocalStorage panierStorage = new LocalStorage("panier");
                                var paniers = panierStorage.getItem("panier");
                                OrderContent orderContent = OrderContent.fromJson(jsonDecode(paniers));
                                SendCommand sendComand = new SendCommand(
                                    id :id.toString(),
                                    shipping: fraisLivraison,
                                  orderContent:  orderContent,
                                  total: orderContent.total.toString(),
                                  poids: poids
                                  );
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => delivery(sendCommand: sendComand)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Container(
                                    height: 40.0,
                                    width: 120.0,
                                    decoration: BoxDecoration(
                                      color:  Color(0xFFCD0007),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Commander",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Sans",
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) ,
                      ],
                    ),
                  ),
                ),
              );
            },
            scrollDirection: Axis.vertical,
          ): noItemCart()
      );
    }
  }

  ///
///
/// If no item cart this class showing
///
class noItemCart extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return  Container(
      width: 500.0,
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
            Image.asset(
              "assets/imgIllustration/IlustrasiCart.png",
              height: 300.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              "Aucun produit dans le panier",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.5,
                  color: Colors.black26.withOpacity(0.2),
                  fontFamily: "Popins"),
            ),
          ],
        ),
      ),
    );
  }
}
