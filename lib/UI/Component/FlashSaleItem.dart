import 'package:flutter/material.dart';
import 'package:gociapp/Data/Model/Produit.dart';
import 'package:gociapp/UI/HomeUIComponent/DetailProduct.dart';

class flashSaleItem extends StatelessWidget {
  Produit produit;

  flashSaleItem(
      {this.produit});
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new detailProduk(produit),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 850)));
      },
      child: Container(
        height: 305,
        width: 145.0,
        color: Colors.white,
        margin: EdgeInsets.only(right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 140.0,
              width: 145.0,
              child: Image.network(
                produit.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 80.0,
              width: 145.0,
              child:  Padding(
                padding: EdgeInsets.only(left: 8.0, right: 3.0, top: 15.0),
                child: Text(produit.nom,
                    style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Sans")),
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 145.0,
              child:  Padding(
                padding: EdgeInsets.only(left: 10.0, top: 5.0),
                child: Text(produit.regular_price + "FCFA",
                    style: TextStyle(
                        fontSize: 10.5,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Sans")),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 10.0, top: 5.0),
              child: Text(produit.sale_price + "FCFA",
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFFCD0007),
                      fontWeight: FontWeight.w800,
                      fontFamily: "Sans")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10.0),
              child: Text(
                produit.stock == null ? " 0" : produit.stock,
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Sans",
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 10.0),
              child: Container(
                height: 5.0,
                width: 50,
                decoration: BoxDecoration(
                    color: Color(0xFFFFA500),
                    borderRadius:
                    BorderRadius.all(Radius.circular(4.0)),
                    shape: BoxShape.rectangle),
              ),
            ),

          ],
        ),
      ),
    );
  }
}