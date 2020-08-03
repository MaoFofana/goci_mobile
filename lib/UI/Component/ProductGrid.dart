import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gociapp/Data/Model/Produit.dart';
import 'package:gociapp/UI/HomeUIComponent/DetailProduct.dart';

/// ItemGrid class

class ProductGrid extends StatelessWidget {
  @override
  Produit item;
  ProductGrid(this.item);
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new detailProduk(item, vandorName: "",),
              transitionDuration: Duration(milliseconds: 900),
              /// Set animation Opacity in route to detailProduk layout
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              }));
        },
        child: Container(
          width: mediaQueryData.size.width/2.3,
          height: mediaQueryData.size.height,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: mediaQueryData.size.height / 5.3,
                        width: 200.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7.0),
                                topRight: Radius.circular(7.0)),
                            image: DecorationImage(
                                image: new NetworkImage(item.image), fit: BoxFit.contain)),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 7.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child:  Container(child:
                    Center(
                      child: Text(
                        item.nom,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,

                        ),
                      ),
                    ),
                    height: 100,)
                  ),
                  Padding(padding: EdgeInsets.only(top: 1.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      item.prix + " FCFA",
                      style: TextStyle(
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              item.regular_price != null? item.regular_price + " FCFA" : "" ,
                              style: TextStyle(
                                  fontFamily: "Sans",
                                  color: Colors.black26,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )

    );
  }
}